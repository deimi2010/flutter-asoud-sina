import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:asood/features/market/presentation/widgets/create_product/position_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTagSection extends StatelessWidget {
  const SelectTagSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        final bloc = context.read<AddProductBloc>();

        return Container(
          width: Dimensions.width,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.06),
          decoration: BoxDecoration(
            color: Colora.scaffold,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(
                  vertical: Dimensions.height * 0.01,
                ),
                child: Text(
                  'برچسب‌ها : ',
                  style: TextStyle(
                    color: Colora.primaryColor,
                    fontSize: Dimensions.width * 0.035,
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: Dimensions.width * 0.02,
                children:
                    TagEnum.values.map((tag) {
                      return _tagRadio(tag, state.productTag, (selected) {
                        bloc.add(ProductTagSaleEvent(tag: selected));
                      });
                    }).toList(),
              ),
              PositionSelectorWidget(
                selectedPosition: state.productPosition,
                onChanged: (value) {
                  bloc.add(ProductTagSaleEvent(position: value));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tagRadio(
    TagEnum tag,
    TagEnum selectedTag,
    Function(TagEnum) onChanged,
  ) {
    String label;
    switch (tag) {
      case TagEnum.newProduct:
        label = 'جدید';
        break;
      case TagEnum.specialOffer:
        label = 'پیشنهاد ویژه';
        break;
      case TagEnum.comingSoon:
        label = 'بزودی';
        break;
      case TagEnum.none:
        label = 'هیچ';
        break;
    }

    return Row(
      spacing: 5,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colora.primaryColor,
            fontSize: Dimensions.width * 0.03,
          ),
        ),
        Radio<TagEnum>(
          value: tag,
          groupValue: selectedTag,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fillColor: WidgetStateProperty.all(Colora.primaryColor),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ],
    );
  }
}
