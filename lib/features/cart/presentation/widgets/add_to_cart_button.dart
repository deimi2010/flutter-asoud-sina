import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/cart/presentation/bloc/cart_bloc.dart';

class AddToCartButton extends StatelessWidget {
  final String? productId;
  final String? productName;
  final String? affiliateId;
  final String? affiliateName;
  final int quantity;
  final VoidCallback? onSuccess;

  const AddToCartButton({
    super.key,
    this.productId,
    this.productName,
    this.affiliateId,
    this.affiliateName,
    this.quantity = 1,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('محصول به سبد خرید اضافه شد'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          onSuccess?.call();
        } else if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final isLoading = state is CartLoading;

          return Container(
            decoration: BoxDecoration(
              color: Colora.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: MaterialButton(
              onPressed: isLoading
                  ? null
                  : () {
                      final data = <String, dynamic>{
                        'quantity': quantity,
                      };

                      if (productId != null) {
                        data['product_id'] = productId;
                      } else if (productName != null) {
                        data['product_name'] = productName;
                      } else if (affiliateId != null) {
                        data['affiliate_id'] = affiliateId;
                      } else if (affiliateName != null) {
                        data['affiliate_name'] = affiliateName;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('لطفا محصول یا محصول وابسته را مشخص کنید'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      context.read<CartBloc>().add(AddItemToCart(data));
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
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colora.scaffold,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'افزودن به سبد خرید',
                          style: TextStyle(
                            color: Colora.scaffold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

