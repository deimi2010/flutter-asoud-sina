import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:asood/features/payment/domain/models/payment_model.dart';

class PaymentScreen extends StatelessWidget {
  final double amount;
  final String targetContent;
  final String targetId;

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.targetContent,
    required this.targetId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<PaymentBloc>(),
      child: _PaymentScreenContent(
        amount: amount,
        targetContent: targetContent,
        targetId: targetId,
      ),
    );
  }
}

class _PaymentScreenContent extends StatefulWidget {
  final double amount;
  final String targetContent;
  final String targetId;

  const _PaymentScreenContent({
    required this.amount,
    required this.targetContent,
    required this.targetId,
  });

  @override
  State<_PaymentScreenContent> createState() => _PaymentScreenContentState();
}

class _PaymentScreenContentState extends State<_PaymentScreenContent> {
  String? selectedGateway;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');
    
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is PaymentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is PaymentCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('پرداخت ایجاد شد'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is PaymentRedirectReady) {
                if (state.redirectUrl != null) {
                  // TODO: Open WebView or browser for payment gateway
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Redirecting to: ${state.redirectUrl}'),
                    ),
                  );
                }
              } else if (state is PaymentVerified) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('پرداخت با موفقیت انجام شد'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.height * 0.11),
                        _buildAmountCard(formatter),
                        SizedBox(height: Dimensions.height * 0.02),
                        _buildGatewaySelector(),
                        SizedBox(height: Dimensions.height * 0.02),
                        _buildPaymentButton(context, state),
                      ],
                    ),
                  ),
                  const NewAppBar(title: 'پرداخت'),
                  if (state is PaymentLoading ||
                      state is PaymentRedirecting ||
                      state is PaymentVerifying)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAmountCard(NumberFormat formatter) {
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
            'مبلغ پرداخت',
            style: TextStyle(
              color: Colora.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Dimensions.height * 0.02),
          Text(
            '${formatter.format(widget.amount)} تومان',
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

  Widget _buildGatewaySelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.05),
      padding: EdgeInsets.all(Dimensions.width * 0.04),
      decoration: BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'انتخاب درگاه پرداخت:',
            style: TextStyle(
              color: Colora.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Dimensions.height * 0.01),
          _buildGatewayOption('زرین‌پال', 'zarinpal'),
        ],
      ),
    );
  }

  Widget _buildGatewayOption(String label, String value) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: selectedGateway,
      onChanged: (value) {
        setState(() {
          selectedGateway = value;
        });
      },
      activeColor: Colora.primaryColor,
    );
  }

  Widget _buildPaymentButton(BuildContext context, PaymentState state) {
    final isLoading = state is PaymentLoading ||
        state is PaymentRedirecting ||
        state is PaymentVerifying;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.05),
      decoration: BoxDecoration(
        color: Colora.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: MaterialButton(
        onPressed: isLoading || selectedGateway == null
            ? null
            : () {
                context.read<PaymentBloc>().add(
                      CreatePayment({
                        'amount': widget.amount,
                        'target_content': widget.targetContent,
                        'target_id': widget.targetId,
                        'gateway': selectedGateway,
                      }),
                    );
              },
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'پرداخت',
                style: TextStyle(
                  color: Colora.scaffold,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

