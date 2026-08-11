import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        return Container(
          height: Dimensions.height * 0.06,
          decoration: BoxDecoration(
            color: Colora.primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.1),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //product
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'کالا و محصول',
                  style: TextStyle(
                    color: Colora.scaffold,
                    fontSize: Dimensions.width * 0.035,
                  ),
                ),
              ),
              Expanded(
                child: RadioListTile(
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  fillColor: WidgetStateProperty.all(Colora.scaffold),
                  value: ProductType.good,
                  groupValue: state.productType,

                  onChanged: (value) {
                    context.read<AddProductBloc>().add(
                      const ProductTypeEvent(type: ProductType.good),
                    );
                  },
                ),
              ),

              //product
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'خدمات',
                  style: TextStyle(
                    color: Colora.scaffold,
                    fontSize: Dimensions.width * 0.035,
                  ),
                ),
              ),
              Expanded(
                child: RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  dense: false,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  fillColor: WidgetStateProperty.all(Colora.scaffold),
                  value: ProductType.service,
                  groupValue: state.productType,
                  onChanged: (value) {
                    context.read<AddProductBloc>().add(
                      const ProductTypeEvent(type: ProductType.service),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
