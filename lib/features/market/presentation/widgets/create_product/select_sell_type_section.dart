import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSellTypeSection extends StatelessWidget {
  const SelectSellTypeSection({super.key});

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
              _buildSectionTitle('شیوه فروش :'),
              _buildSellTypeRow(state, bloc),
              _buildSectionTitle('شیوه و هزینه ارسال مرسویه :'),
              _buildSendPriceRow(state, bloc),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(vertical: Dimensions.height * 0.01),
      child: Text(
        title,
        style: TextStyle(
          color: Colora.primaryColor,
          fontSize: Dimensions.width * 0.035,
        ),
      ),
    );
  }

  Widget _buildSellTypeRow(AddProductState state, AddProductBloc bloc) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          SellTypeEnum.values.map((type) {
            final label = _getSellTypeLabel(type);
            return Expanded(
              child: Row(
                children: [
                  Expanded(child: _buildLabel(label)),
                  Flexible(
                    child: Radio<SellTypeEnum>(
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),

                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor: WidgetStateProperty.all(Colora.primaryColor),
                      value: type,
                      groupValue: state.productSellType,
                      onChanged: (value) {
                        bloc.add(ProductTagSaleEvent(sellType: value));
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildSendPriceRow(AddProductState state, AddProductBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          SendPriceEnum.values.map((type) {
            final label = _getSendPriceLabel(type);
            return Expanded(
              child: Row(
                spacing: 8,
                children: [
                  Expanded(child: _buildLabel(label)),
                  Flexible(
                    child: Radio<SendPriceEnum>(
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor: WidgetStateProperty.all(Colora.primaryColor),
                      value: type,
                      groupValue: state.productSendPrice,
                      onChanged: (value) {
                        bloc.add(ProductTagSaleEvent(sendPrice: value));
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colora.primaryColor,
          fontSize: Dimensions.width * 0.03,
        ),
      ),
    );
  }

  String _getSellTypeLabel(SellTypeEnum type) {
    switch (type) {
      case SellTypeEnum.online:
        return 'فروش آنلاین';
      case SellTypeEnum.person:
        return 'فروش حضوری';
      case SellTypeEnum.both:
        return 'هر دو';
    }
  }

  String _getSendPriceLabel(SendPriceEnum type) {
    switch (type) {
      case SendPriceEnum.market:
        return 'به عهده فروشگاه';
      case SendPriceEnum.customer:
        return 'به عهده مشتری';
      case SendPriceEnum.free:
        return 'رایگان';
    }
  }
}
