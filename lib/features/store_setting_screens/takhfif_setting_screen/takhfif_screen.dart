import 'dart:math';

import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/models/market_model.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/features/store_setting_screens/takhfif_setting_screen/discount_api_service.dart';
import 'package:asood/features/store_setting_screens/takhfif_setting_screen/discount_model.dart';
import 'package:asood/features/store_setting_screens/takhfif_setting_screen/discount_storage.dart';
import 'package:asood/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class TakhfifScreen extends StatefulWidget {
  const TakhfifScreen({required this.market, super.key});

  final MarketModel market;

  @override
  State<TakhfifScreen> createState() => _TakhfifScreenState();
}

class _TakhfifScreenState extends State<TakhfifScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _percentageController = TextEditingController();
  final _limitationController = TextEditingController();
  final _validityDaysController = TextEditingController();
  final _storage = const DiscountStorage();

  late final DiscountApiService _api;
  List<MarketDiscount> _remote = [];
  List<MarketDiscount> _pending = [];
  bool _loading = true;
  bool _submitting = false;
  String? _loadError;

  String get _marketId => widget.market.id ?? '';

  @override
  void initState() {
    super.initState();
    _api = DiscountApiService(locator<DioClient>());
    _load();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _percentageController.dispose();
    _limitationController.dispose();
    _validityDaysController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (_marketId.isEmpty) {
      setState(() {
        _loading = false;
        _loadError = 'شناسه فروشگاه در دسترس نیست';
      });
      return;
    }
    final pending = await _storage.load(_marketId);
    if (mounted) setState(() => _pending = pending);
    try {
      final remote = await _api.list(_marketId);
      if (!mounted) return;
      setState(() {
        _remote = remote;
        _loading = false;
        _loadError = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadError = 'ارتباط با سرور برقرار نشد؛ پیش‌نویس‌های محلی محفوظ‌اند.';
      });
    }
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;
    final validityDays = int.tryParse(_validityDaysController.text.trim());
    final now = DateTime.now();
    final requestId =
        '${now.microsecondsSinceEpoch}-${Random.secure().nextInt(1 << 32)}';
    final pending = MarketDiscount(
      id: requestId,
      clientRequestId: requestId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      percentage: int.parse(_percentageController.text.trim()),
      limitation: int.parse(_limitationController.text.trim()),
      consumed: 0,
      reserved: 0,
      expiry:
          validityDays == null ? null : now.add(Duration(days: validityDays)),
      createdAt: now,
      status: MarketDiscountStatus.pending,
    );
    setState(() {
      _submitting = true;
      _pending.insert(0, pending);
    });
    await _storage.save(_marketId, _pending);
    try {
      final created = await _api.create(_marketId, pending);
      _pending.removeWhere((item) => item.id == pending.id);
      await _storage.save(_marketId, _pending);
      if (!mounted) return;
      setState(() {
        _remote.insert(0, created);
        _submitting = false;
      });
      _clearForm();
      _message('کد تخفیف ساخته شد و آماده اشتراک‌گذاری است.');
    } catch (_) {
      if (!mounted) return;
      setState(() => _submitting = false);
      _clearForm();
      _message('سرور در دسترس نیست؛ تخفیف برای ارسال بعدی ذخیره شد.');
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _descriptionController.clear();
    _percentageController.clear();
    _limitationController.clear();
    _validityDaysController.clear();
  }

  Future<void> _retry(MarketDiscount item) async {
    try {
      final created = await _api.create(_marketId, item);
      _pending.removeWhere((value) => value.id == item.id);
      await _storage.save(_marketId, _pending);
      if (!mounted) return;
      setState(() => _remote.insert(0, created));
      _message('کد تخفیف با موفقیت ارسال شد.');
    } catch (_) {
      _message('ارسال انجام نشد؛ بعداً دوباره تلاش کنید.');
    }
  }

  Future<void> _removePending(MarketDiscount item) async {
    setState(() => _pending.removeWhere((value) => value.id == item.id));
    await _storage.save(_marketId, _pending);
  }

  Future<void> _deactivate(MarketDiscount item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('غیرفعال‌سازی تخفیف'),
            content: const Text('این کد دیگر در خرید قابل استفاده نخواهد بود.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('انصراف'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('غیرفعال کن'),
              ),
            ],
          ),
    );
    if (confirmed != true) return;
    try {
      final updated = await _api.deactivate(item.id);
      final index = _remote.indexWhere((value) => value.id == item.id);
      if (!mounted) return;
      setState(() {
        if (index >= 0) _remote[index] = updated;
      });
      _message('کد تخفیف غیرفعال شد.');
    } catch (_) {
      _message('غیرفعال‌سازی انجام نشد.');
    }
  }

  String _shareText(MarketDiscount item) {
    final storeName =
        widget.market.name?.trim().isNotEmpty == true
            ? widget.market.name!.trim()
            : 'فروشگاه';
    final businessId = widget.market.businessId?.trim() ?? '';
    final storeUrl =
        businessId.isEmpty
            ? 'https://asoud.ir/'
            : Uri.https('$businessId.asoud.ir', '/').toString();
    final expiry =
        item.expiry == null
            ? 'بدون تاریخ انقضا'
            : 'اعتبار تا تاریخ ${_date(item.expiry!)}';
    return '${item.title} $storeName\n'
        '${item.percentage}٪ تخفیف با کد ${item.code}\n'
        '$expiry\n$storeUrl';
  }

  Future<void> _copy(MarketDiscount item) async {
    await Clipboard.setData(ClipboardData(text: _shareText(item)));
    _message('متن تخفیف و لینک فروشگاه کپی شد.');
  }

  Future<void> _share(MarketDiscount item) async {
    await SharePlus.instance.share(ShareParams(text: _shareText(item)));
  }

  void _message(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final discounts = [..._pending, ..._remote];
    return Scaffold(
      appBar: DefaultAppBar(),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 28),
          children: [
            _buildForm(),
            const SizedBox(height: 18),
            Text(
              'تخفیف‌های ساخته‌شده',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_loadError != null) ...[
              Text(_loadError!, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: const Text('تلاش مجدد'),
              ),
            ],
            if (!_loading && discounts.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 28),
                child: Text(
                  'هنوز کد تخفیفی ساخته نشده است.',
                  textAlign: TextAlign.center,
                ),
              ),
            ...discounts.map(_buildCard),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'ساخت کد تخفیف',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              _field(
                controller: _titleController,
                label: 'عنوان تخفیف',
                validator: _required,
              ),
              _field(
                controller: _descriptionController,
                label: 'توضیحات',
                validator: _required,
                maxLines: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      controller: _percentageController,
                      label: 'درصد تخفیف',
                      keyboardType: TextInputType.number,
                      validator: (value) => _numberRange(value, 1, 100),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _field(
                      controller: _limitationController,
                      label: 'تعداد قابل استفاده',
                      keyboardType: TextInputType.number,
                      validator: (value) => _numberRange(value, 1, 1000000),
                    ),
                  ),
                ],
              ),
              _field(
                controller: _validityDaysController,
                label: 'مدت اعتبار (روز، اختیاری)',
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? null
                            : _numberRange(value, 1, 3650),
              ),
              const SizedBox(height: 4),
              FilledButton.icon(
                onPressed: _submitting ? null : _submit,
                icon:
                    _submitting
                        ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.add),
                label: const Text('ساخت تخفیف'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        inputFormatters:
            keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
        validator: validator,
      ),
    );
  }

  Widget _buildCard(MarketDiscount item) {
    final status = _status(item.status);
    return Card(
      margin: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: status.$2.withValues(alpha: .14),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(status.$1, style: TextStyle(color: status.$2)),
                ),
              ],
            ),
            if (item.description.isNotEmpty) ...[
              const SizedBox(height: 7),
              Text(item.description),
            ],
            const SizedBox(height: 10),
            if (item.code != null)
              SelectableText(
                'کد: ${item.code}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            Text('${item.percentage}٪ تخفیف'),
            Text(
              'مصرف‌شده: ${item.consumed} از ${item.limitation}'
              '${item.remaining == null ? '' : ' — باقی‌مانده: ${item.remaining}'}',
            ),
            if (item.reserved > 0) Text('رزرو موقت: ${item.reserved}'),
            Text(
              item.expiry == null
                  ? 'بدون تاریخ انقضا'
                  : 'اعتبار تا ${_date(item.expiry!)}',
            ),
            const SizedBox(height: 10),
            if (item.isPending)
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _retry(item),
                    icon: const Icon(Icons.sync),
                    label: const Text('تلاش مجدد'),
                  ),
                  TextButton.icon(
                    onPressed: () => _removePending(item),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('حذف پیش‌نویس'),
                  ),
                ],
              )
            else
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  OutlinedButton.icon(
                    onPressed: item.canShare ? () => _copy(item) : null,
                    icon: const Icon(Icons.copy),
                    label: const Text('کپی متن و لینک'),
                  ),
                  OutlinedButton.icon(
                    onPressed: item.canShare ? () => _share(item) : null,
                    icon: const Icon(Icons.share),
                    label: const Text('اشتراک‌گذاری'),
                  ),
                  TextButton.icon(
                    onPressed:
                        item.canDeactivate ? () => _deactivate(item) : null,
                    icon: const Icon(Icons.block),
                    label: const Text('غیرفعال‌سازی'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  (String, Color) _status(MarketDiscountStatus status) => switch (status) {
    MarketDiscountStatus.pending => ('در انتظار ارسال', Colors.orange),
    MarketDiscountStatus.active => ('فعال', Colors.green),
    MarketDiscountStatus.expired => ('منقضی', Colors.red),
    MarketDiscountStatus.full => ('تکمیل ظرفیت', Colors.deepOrange),
    MarketDiscountStatus.inactive => ('غیرفعال', Colors.grey),
  };

  String _date(DateTime value) {
    final local = value.toLocal();
    return '${local.year}/${local.month.toString().padLeft(2, '0')}/'
        '${local.day.toString().padLeft(2, '0')}';
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'این فیلد الزامی است' : null;

  String? _numberRange(String? value, int min, int max) {
    final number = int.tryParse(value?.trim() ?? '');
    if (number == null || number < min || number > max) {
      return 'عدد بین $min تا $max وارد کنید';
    }
    return null;
  }
}
