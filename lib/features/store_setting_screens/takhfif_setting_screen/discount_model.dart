enum MarketDiscountStatus { pending, active, expired, full, inactive }

class MarketDiscount {
  const MarketDiscount({
    required this.id,
    required this.title,
    required this.description,
    required this.percentage,
    required this.limitation,
    required this.consumed,
    required this.reserved,
    required this.status,
    required this.createdAt,
    this.code,
    this.expiry,
    this.remaining,
    this.clientRequestId,
  });

  final String id;
  final String title;
  final String description;
  final int percentage;
  final int limitation;
  final int consumed;
  final int reserved;
  final int? remaining;
  final String? code;
  final DateTime? expiry;
  final DateTime createdAt;
  final String? clientRequestId;
  final MarketDiscountStatus status;

  bool get isPending => status == MarketDiscountStatus.pending;
  bool get canShare => !isPending && code != null && code!.isNotEmpty;
  bool get canDeactivate => status == MarketDiscountStatus.active;

  factory MarketDiscount.fromApi(Map<String, dynamic> json) {
    return MarketDiscount(
      id: json['id'].toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      percentage: _toInt(json['percentage']),
      limitation: _toInt(json['limitation']),
      consumed: _toInt(json['consumed']),
      reserved: _toInt(json['reserved']),
      remaining: json['remaining'] == null ? null : _toInt(json['remaining']),
      code: json['code']?.toString(),
      expiry: DateTime.tryParse((json['expiry'] ?? '').toString()),
      createdAt:
          DateTime.tryParse((json['created_at'] ?? '').toString()) ??
          DateTime.now(),
      status: _statusFromString(json['status']?.toString()),
    );
  }

  factory MarketDiscount.fromPendingJson(Map<String, dynamic> json) {
    final requestId = json['client_request_id'].toString();
    return MarketDiscount(
      id: requestId,
      clientRequestId: requestId,
      title: json['title'].toString(),
      description: json['description'].toString(),
      percentage: _toInt(json['percentage']),
      limitation: _toInt(json['limitation']),
      consumed: 0,
      reserved: 0,
      expiry: DateTime.tryParse((json['expiry'] ?? '').toString()),
      createdAt:
          DateTime.tryParse((json['created_at'] ?? '').toString()) ??
          DateTime.now(),
      status: MarketDiscountStatus.pending,
    );
  }

  Map<String, dynamic> toPendingJson() => {
    'client_request_id': clientRequestId ?? id,
    'title': title,
    'description': description,
    'percentage': percentage,
    'limitation': limitation,
    'expiry': expiry?.toUtc().toIso8601String(),
    'created_at': createdAt.toUtc().toIso8601String(),
  };

  Map<String, dynamic> toCreatePayload(String marketId) => {
    'content_type': 'market',
    'object_id': marketId,
    'title': title,
    'description': description,
    'percentage': percentage,
    'limitation': limitation,
    'users': <String>[],
    if (expiry != null) 'expiry': expiry!.toUtc().toIso8601String(),
    'client_request_id': clientRequestId ?? id,
  };

  static int _toInt(dynamic value) =>
      value is int ? value : int.tryParse(value?.toString() ?? '') ?? 0;

  static MarketDiscountStatus _statusFromString(String? value) {
    return switch (value) {
      'expired' => MarketDiscountStatus.expired,
      'full' => MarketDiscountStatus.full,
      'inactive' => MarketDiscountStatus.inactive,
      _ => MarketDiscountStatus.active,
    };
  }
}
