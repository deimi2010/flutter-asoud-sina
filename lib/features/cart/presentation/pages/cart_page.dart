import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/simple_bot_navbar.dart';
import 'package:asood/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:asood/features/cart/domain/models/cart_model.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<CartBloc>()..add(const LoadCart()),
      child: const _CartScreenContent(),
    );
  }
}

class _CartScreenContent extends StatelessWidget {
  const _CartScreenContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is CartCheckoutSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              } else if (state is CartCheckoutError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is CartLoading || state is CartInitial) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colora.backgroundDialog,
                  ),
                );
              }

              if (state is CartLoaded) {
                if (state.cart.items.isEmpty) {
                  return _buildEmptyCart(context);
                }
                return _buildCartContent(context, state.cart);
              }

              if (state is CartError) {
                return _buildErrorState(context, state.message);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: Dimensions.height * 0.11),
            Expanded(
              child: Center(
                child: Text(
                  'سبد خرید شما خالی است',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colora.backgroundSwitch,
                  ),
                ),
              ),
            ),
          ],
        ),
        const NewAppBar(title: 'سبد خرید'),
      ],
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
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colora.backgroundSwitch,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(const LoadCart());
                      },
                      child: const Text('تلاش مجدد'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const NewAppBar(title: 'سبد خرید'),
      ],
    );
  }

  Widget _buildCartContent(BuildContext context, CartModel cart) {
    final formatter = NumberFormat('#,###');
    
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height * 0.11),
              SizedBox(
                height: Dimensions.height * 0.6,
                width: Dimensions.width,
                child: ListView.builder(
                  itemCount: cart.items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _buildCartItem(context, cart.items[index]);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: Dimensions.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                      context,
                      'بازگشت',
                      () => Navigator.pop(context),
                    ),
                    _buildActionButton(
                      context,
                      'تکمیل خرید',
                      () => _showCheckoutDialog(context, cart),
                    ),
                  ],
                ),
              ),
              const SimpleBotNavBar(),
            ],
          ),
        ),
        const NewAppBar(title: 'سبد خرید'),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartItemModel item) {
    return Container(
      width: Dimensions.width * 0.9,
      height: Dimensions.height * 0.15,
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.height * 0.005,
        horizontal: Dimensions.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: Dimensions.width * 0.32,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    child: Container(
                      color: Colora.borderAvatar,
                      child: item.itemImage != null
                          ? Image.network(
                              item.itemImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image_not_supported);
                              },
                            )
                          : const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  width: Dimensions.width * 0.32,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        context.read<CartBloc>().add(RemoveCartItem(item.id));
                      },
                      child: Container(
                        width: Dimensions.width * 0.25,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.delete_rounded,
                              color: Colora.scaffold,
                              size: 20,
                            ),
                            Text(
                              'حذف کردن',
                              style: TextStyle(
                                color: Colora.scaffold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Dimensions.width * 0.6,
            child: Column(
              children: [
                Container(
                  width: Dimensions.width * 0.6,
                  height: Dimensions.height * 0.06,
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width * 0.03,
                    vertical: Dimensions.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: Colora.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item.itemName,
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.03,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: Dimensions.width * 0.7,
                  height: Dimensions.height * 0.07,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width * 0.03,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        item.price != null
                            ? '${NumberFormat('#,###').format(item.price)} تومان'
                            : 'قیمت نامشخص',
                        style: TextStyle(
                          color: Colora.scaffold,
                          fontSize: Dimensions.width * 0.03,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 2,
                              ),
                              child: InkWell(
                                onTap: () {
                                  context.read<CartBloc>().add(
                                        UpdateCartItem(
                                          item.id,
                                          {'quantity': item.quantity + 1},
                                        ),
                                      );
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colora.scaffold,
                                  size: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 2,
                              ),
                              child: Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  color: Colora.scaffold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4,
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (item.quantity > 1) {
                                    context.read<CartBloc>().add(
                                          UpdateCartItem(
                                            item.id,
                                            {'quantity': item.quantity - 1},
                                          ),
                                        );
                                  }
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colora.scaffold,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colora.primaryColor,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.07,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colora.scaffold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CartModel cart) {
    showDialog(
      context: context,
      builder: (context) => _CheckoutDialog(cart: cart),
    );
  }
}

class _CheckoutDialog extends StatefulWidget {
  final CartModel cart;

  const _CheckoutDialog({required this.cart});

  @override
  State<_CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<_CheckoutDialog> {
  String? selectedPaymentMethod;
  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Dimensions.width * 0.9,
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.height * 0.02,
          horizontal: Dimensions.width * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colora.scaffold,
          borderRadius: BorderRadius.circular(26),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height * 0.06,
                margin: EdgeInsets.only(
                  bottom: Dimensions.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colora.primaryColor,
                  borderRadius: BorderRadius.circular(26),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'تکمیل خرید',
                  style: TextStyle(
                    color: Colora.scaffold,
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height * 0.02),
              Text(
                'مبلغ کل: ${formatter.format(widget.cart.totalPrice)} تومان',
                style: const TextStyle(
                  color: Colora.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Dimensions.height * 0.02),
              _buildPaymentMethodSelector(),
              SizedBox(height: Dimensions.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildDialogButton(
                    context,
                    'انصراف',
                    () => Navigator.pop(context),
                    Colors.grey,
                  ),
                  SizedBox(width: Dimensions.width * 0.03),
                  _buildDialogButton(
                    context,
                    'ثبت نهایی',
                    () {
                      if (selectedPaymentMethod != null) {
                        context.read<CartBloc>().add(
                              CheckoutCart({
                                'type': selectedPaymentMethod,
                                'description': 'Order placed',
                              }),
                            );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('لطفا روش پرداخت را انتخاب کنید'),
                          ),
                        );
                      }
                    },
                    Colora.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'شیوه پرداخت:',
          style: TextStyle(
            color: Colora.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Dimensions.height * 0.01),
        _buildPaymentOption('نقد', 'cash'),
        _buildPaymentOption('اینترنتی', 'online'),
        _buildPaymentOption('حواله', 'transfer'),
        _buildPaymentOption('چک', 'check'),
      ],
    );
  }

  Widget _buildPaymentOption(String label, String value) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      activeColor: Colora.primaryColor,
    );
  }

  Widget _buildDialogButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
    Color color,
  ) {
    return Container(
      width: Dimensions.width * 0.3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colora.scaffold,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

