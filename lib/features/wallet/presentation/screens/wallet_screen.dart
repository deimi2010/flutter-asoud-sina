import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:asood/features/wallet/domain/models/wallet_model.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<WalletBloc>()..add(const LoadWalletBalance()),
      child: const _WalletScreenContent(),
    );
  }
}

class _WalletScreenContent extends StatelessWidget {
  const _WalletScreenContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<WalletBloc, WalletState>(
            listener: (context, state) {
              if (state is WalletError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is WalletPaymentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is WalletPaymentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is WalletLoading || state is WalletInitial) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colora.backgroundDialog,
                  ),
                );
              }

              if (state is WalletLoaded) {
                return _buildWalletContent(context, state);
              }

              if (state is WalletError) {
                return _buildErrorState(context, state.message);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: Dimensions.height * 0.11),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colora.backgroundSwitch,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WalletBloc>().add(const LoadWalletBalance());
                      },
                      child: const Text('تلاش مجدد'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const NewAppBar(title: 'کیف پول'),
      ],
    );
  }

  Widget _buildWalletContent(BuildContext context, WalletLoaded state) {
    final formatter = NumberFormat('#,###');
    
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height * 0.11),
              _buildBalanceCard(context, state.wallet, formatter),
              SizedBox(height: Dimensions.height * 0.02),
              _buildActionButtons(context),
              SizedBox(height: Dimensions.height * 0.02),
              _buildTransactionsSection(context, state),
            ],
          ),
        ),
        const NewAppBar(title: 'کیف پول'),
      ],
    );
  }

  Widget _buildBalanceCard(
    BuildContext context,
    WalletModel wallet,
    NumberFormat formatter,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.05,
        vertical: Dimensions.height * 0.02,
      ),
      padding: EdgeInsets.all(Dimensions.width * 0.05),
      decoration: BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'موجودی کیف پول',
            style: TextStyle(
              color: Colora.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Dimensions.height * 0.02),
          Text(
            '${formatter.format(wallet.balance)} تومان',
            style: const TextStyle(
              color: Colora.primaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          context,
          'شارژ کیف پول',
          Icons.add_circle_outline,
          () {
            // TODO: Navigate to top-up screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('قابلیت شارژ کیف پول به زودی اضافه می‌شود')),
            );
          },
        ),
        _buildActionButton(
          context,
          'تاریخچه تراکنش‌ها',
          Icons.history,
          () {
            context.read<WalletBloc>().add(const LoadTransactions());
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: Dimensions.width * 0.4,
      decoration: BoxDecoration(
        color: Colora.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colora.scaffold, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colora.scaffold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsSection(BuildContext context, WalletLoaded state) {
    if (state.loadingTransactions) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.transactions.isEmpty) {
      return Container(
        margin: EdgeInsets.all(Dimensions.width * 0.05),
        padding: EdgeInsets.all(Dimensions.width * 0.05),
        decoration: BoxDecoration(
          color: Colora.lightBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'هیچ تراکنشی یافت نشد',
          style: TextStyle(
            color: Colora.primaryColor,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.05),
          child: const Text(
            'تاریخچه تراکنش‌ها',
            style: TextStyle(
              color: Colora.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: Dimensions.height * 0.01),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.transactions.length,
          itemBuilder: (context, index) {
            return _buildTransactionItem(context, state.transactions[index]);
          },
        ),
      ],
    );
  }

  Widget _buildTransactionItem(BuildContext context, TransactionModel transaction) {
    final formatter = NumberFormat('#,###');
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.05,
        vertical: Dimensions.height * 0.005,
      ),
      padding: EdgeInsets.all(Dimensions.width * 0.04),
      decoration: BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.type,
                style: const TextStyle(
                  color: Colora.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (transaction.description != null) ...[
                const SizedBox(height: 4),
                Text(
                  transaction.description!,
                  style: const TextStyle(
                    color: Colora.primaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
              const SizedBox(height: 4),
              Text(
                dateFormatter.format(transaction.createdAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            '${formatter.format(transaction.amount)} تومان',
            style: TextStyle(
              color: transaction.amount > 0 ? Colors.green : Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

