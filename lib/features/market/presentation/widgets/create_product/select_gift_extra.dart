import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';

class SelectGiftExtraProductWidget extends StatelessWidget {
  final String marketId;
  const SelectGiftExtraProductWidget({super.key, required this.marketId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductToggleSection(
              title: 'کالای هدیه',
              isActive: state.productGift,
              onToggle:
                  (value) => context.read<AddProductBloc>().add(
                    ProductExtraEvent(gift: !state.productGift),
                  ),
              onSelectTap:
                  () => _showProductSelector(
                    context,
                    (product) => context.read<AddProductBloc>().add(
                      ChangeProductGiftAndRequiredEvent(
                        selectedProductGift: product,
                      ),
                    ),
                    marketId,
                  ),
              selectedProduct: state.selectedProductGift,
            ),
            ProductToggleSection(
              title: 'کالای همراه',
              isActive: state.productExtra,
              onToggle:
                  (value) => context.read<AddProductBloc>().add(
                    ProductExtraEvent(extra: !state.productExtra),
                  ),
              onSelectTap:
                  () => _showProductSelector(
                    context,
                    (product) => context.read<AddProductBloc>().add(
                      ChangeProductGiftAndRequiredEvent(
                        selectedProductExtra: product,
                      ),
                    ),
                    marketId,
                  ),
              selectedProduct: state.selectedProductExtra,
            ),
          ],
        );
      },
    );
  }

  void _showProductSelector(
    BuildContext context,
    Function(dynamic) onTap,
    String marketId,
  ) {
    context.read<AddProductBloc>().add(
      LoadProductListEvent(marketId: marketId),
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: BlocBuilder<AddProductBloc, AddProductState>(
            builder: (context, state) {
              if (state.giftStatus == CWSStatus.loading) {
                return _loadingWidget();
              } else if (state.giftStatus == CWSStatus.success) {
                return _productGrid(state.productList, onTap, context);
              } else {
                return _errorWidget(context, marketId);
              }
            },
          ),
        );
      },
    );
  }

  Widget _loadingWidget() => SizedBox(
    width: Dimensions.width * 0.7,
    height: Dimensions.height * 0.5,
    child: const Center(
      child: CircularProgressIndicator(color: Colora.primaryColor),
    ),
  );

  Widget _errorWidget(BuildContext context, String marketId) => SizedBox(
    height: Dimensions.height * 0.5,
    child: Column(
      children: [
        SizedBox(
          width: Dimensions.width * 0.7,
          height: Dimensions.height * 0.3,
          child: const Center(
            child: Text(
              'خطا در برقراری اطلاعات',
              style: TextStyle(color: Colora.primaryColor),
            ),
          ),
        ),
        CustomButton(
          onPress:
              () => context.read<AddProductBloc>().add(
                LoadProductListEvent(marketId: marketId),
              ),
          color: Colora.primaryColor,
          textColor: Colors.white,
          height: 40,
          width: Dimensions.width * 0.3,
          text: 'تلاش مجدد',
        ),
      ],
    ),
  );

  Widget _productGrid(
    List<dynamic> products,
    Function(dynamic) onTap,
    BuildContext context,
  ) => SizedBox(
    height: Dimensions.height * 0.5,
    width: double.maxFinite,
    child: GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: Dimensions.height * 0.2,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            onTap(product);
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colora.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Dimensions.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(product.images.first.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product.name,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

class ProductToggleSection extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onSelectTap;
  final Function(bool) onToggle;
  final dynamic selectedProduct;

  const ProductToggleSection({
    required this.title,
    required this.isActive,
    required this.onSelectTap,
    required this.onToggle,
    required this.selectedProduct,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _toggleBar(context),
        if (isActive) ...[
          SizedBox(height: Dimensions.height * 0.01),
          _selectionButton(context),
          SizedBox(height: Dimensions.height * 0.01),
          _productPreview(context),
        ],
      ],
    );
  }

  Widget _toggleBar(BuildContext context) => Container(
    width: Dimensions.width * 0.4,
    height: Dimensions.height * 0.045,
    margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
    padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.01),
    decoration: BoxDecoration(
      color: Colora.scaffold,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colora.primaryColor,
            fontSize: Dimensions.width * 0.035,
          ),
        ),
        CupertinoSwitch(
          activeTrackColor: Colora.primaryColor,
          value: isActive,
          onChanged: onToggle,
        ),
      ],
    ),
  );

  Widget _selectionButton(BuildContext context) => InkWell(
    onTap: onSelectTap,
    borderRadius: BorderRadius.circular(30),
    child: Container(
      width: Dimensions.width * 0.4,
      height: Dimensions.height * 0.045,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.01),
      decoration: BoxDecoration(
        color: Colora.scaffold,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Text(
        'انتخاب $title',
        style: TextStyle(
          color: Colora.primaryColor,
          fontSize: Dimensions.width * 0.035,
        ),
      ),
    ),
  );

  Widget _productPreview(BuildContext context) => Container(
    width: Dimensions.width * 0.4,
    margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
    padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.01),
    decoration: BoxDecoration(
      color: Colora.scaffold,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      spacing: 8,
      children: [
        SizedBox(
          width: Dimensions.width * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '$title :',
                style: TextStyle(
                  color: Colora.primaryColor,
                  fontSize: Dimensions.width * 0.03,
                ),
              ),
              Text(
                selectedProduct?.name ?? 'بدون کالا',
                maxLines: 4,
                style: TextStyle(
                  color: Colora.primaryColor,
                  fontSize: Dimensions.width * 0.03,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: Dimensions.width * 0.16,
          margin: EdgeInsets.symmetric(vertical: Dimensions.height * 0.01),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colora.primaryColor),
                image:
                    selectedProduct?.images.first.image != null
                        ? DecorationImage(
                          image: NetworkImage(
                            selectedProduct.images.first.image,
                          ),
                          fit: BoxFit.cover,
                        )
                        : null,
              ),
              child:
                  selectedProduct?.images.first.image == null
                      ? const Center(
                        child: Text('بدون عکس', textAlign: TextAlign.center),
                      )
                      : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    ),
  );
}
