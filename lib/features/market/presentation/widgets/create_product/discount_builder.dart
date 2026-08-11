import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:asood/features/market/presentation/widgets/create_product/position_selector.dart';

class DiscountBuilder extends StatelessWidget {
  DiscountBuilder({super.key});

  final TextEditingController dayController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: Dimensions.width,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width * 0.03,
            vertical: Dimensions.height * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colora.lightBlue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colora.scaffold,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width * 0.03),
                      child: Text(
                        'نوع تخفیف:',
                        style: TextStyle(
                          color: Colora.primaryColor,
                          fontSize: Dimensions.width * 0.035,
                        ),
                      ),
                    ),
                    Container(
                      width: Dimensions.width * 0.5,
                      height: Dimensions.height * 0.05,
                      margin: EdgeInsets.symmetric(
                        vertical: Dimensions.height * 0.005,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: Colora.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<DiscountType>(
                          dropdownColor: Colora.primaryColor,
                          iconEnabledColor: Colora.scaffold,
                          borderRadius: BorderRadius.circular(15),
                          value:
                              state.discountType == DiscountType.none
                                  ? null
                                  : state.discountType,
                          hint: Text(
                            'انتخاب نمایید',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: Dimensions.width * 0.03,
                            ),
                          ),
                          items:
                              DiscountType.values.map((discount) {
                                return DropdownMenuItem<DiscountType>(
                                  value: discount,
                                  child: Text(
                                    _discountTypeToString(discount),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              context.read<AddProductBloc>().add(
                                DiscountTypeEvent(type: value),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.discountType == DiscountType.percent)
                _percentDiscountBuilder(state, context),
              if (state.discountType == DiscountType.timed)
                _timedDiscountBuilder(state, context),
              if (state.discountType == DiscountType.group)
                _groupDiscountBuilder(state, context),
            ],
          ),
        );
      },
    );
  }

  String _discountTypeToString(DiscountType type) {
    switch (type) {
      case DiscountType.percent:
        return 'تخفیف درصدی';
      case DiscountType.timed:
        return 'تخفیف زمان‌دار';
      case DiscountType.group:
        return 'تخفیف گروهی';
      default:
        return 'انتخاب نمایید';
    }
  }

  Widget _percentDiscountBuilder(AddProductState state, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimensions.height * 0.02),
        percentageMaker(state, context),
        SizedBox(height: Dimensions.height * 0.02),
        PositionSelectorWidget(
          whiteMode: true,
          selectedPosition: state.discountPosition,
          onChanged: (value) {
            context.read<AddProductBloc>().add(
              DiscountValuesEvent(position: value),
            );
          },
        ),
      ],
    );
  }

  Widget _timedDiscountBuilder(AddProductState state, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimensions.height * 0.02),
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: dayMaker(state, context)),
            Flexible(flex: 2, child: percentageMaker(state, context)),
          ],
        ),
        SizedBox(height: Dimensions.height * 0.02),
        PositionSelectorWidget(
          whiteMode: true,
          selectedPosition: state.discountPosition,
          onChanged: (value) {
            context.read<AddProductBloc>().add(
              DiscountValuesEvent(position: value),
            );
          },
        ),
      ],
    );
  }

  Widget _groupDiscountBuilder(AddProductState state, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimensions.height * 0.02),
        percentageMaker(state, context),
        SizedBox(height: Dimensions.height * 0.02),
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: peopleMaker(state, context)),
            Flexible(flex: 2, child: dayMaker(state, context)),
          ],
        ),
        SizedBox(height: Dimensions.height * 0.02),
        PositionSelectorWidget(
          whiteMode: true,
          selectedPosition: state.discountPosition,
          onChanged: (value) {
            context.read<AddProductBloc>().add(
              DiscountValuesEvent(position: value),
            );
          },
        ),
      ],
    );
  }

  Widget percentageMaker(AddProductState state, BuildContext context) {
    return Container(
      width: Dimensions.width * 0.4,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.04,
        vertical: Dimensions.height * 0.004,
      ),
      decoration: BoxDecoration(
        color: Colora.scaffold,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Text(
            'درصد تخفیف:',
            style: TextStyle(
              color: Colora.primaryColor,
              fontSize: Dimensions.width * 0.035,
            ),
          ),
          SizedBox(width: Dimensions.width * 0.02),

          Expanded(
            child: DropdownButton<int>(
              icon: SizedBox.shrink(),
              borderRadius: BorderRadius.circular(15),
              value: state.discountPercentage,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  context.read<AddProductBloc>().add(
                    DiscountValuesEvent(percentage: newValue),
                  );
                }
              },
              items: List.generate(99, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,

                  child: Text(
                    '%${index + 1}',
                    style: TextStyle(
                      color: Colora.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
              underline: SizedBox(), // حذف خط زیر دکمه
              isExpanded: true,
              hint: Text(
                "انتخاب درصد",
                style: TextStyle(color: Colora.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dayMaker(AddProductState state, BuildContext context) {
    return Container(
      width: Dimensions.width * 0.4,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.04,
        vertical: Dimensions.height * 0.004,
      ),
      decoration: BoxDecoration(
        color: Colora.scaffold,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Text(
            'تعداد روز: ',
            style: TextStyle(
              color: Colora.primaryColor,
              fontSize: Dimensions.width * 0.035,
            ),
          ),
          SizedBox(width: Dimensions.width * 0.02),

          Expanded(
            child: TextField(
              controller: dayController..text = state.discountDays.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.isNotEmpty && int.tryParse(value) != null) {
                  context.read<AddProductBloc>().add(
                    DiscountValuesEvent(daysNumber: int.parse(value)),
                  );
                }
              },
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget peopleMaker(AddProductState state, BuildContext context) {
    return Container(
      width: Dimensions.width * 0.4,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.04,
        vertical: Dimensions.height * 0.004,
      ),
      decoration: BoxDecoration(
        color: Colora.scaffold,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Text(
            'تعداد نفرات: ',
            style: TextStyle(
              color: Colora.primaryColor,
              fontSize: Dimensions.width * 0.035,
            ),
          ),
          SizedBox(width: Dimensions.width * 0.02),

          Expanded(
            child: TextField(
              controller:
                  peopleController..text = state.discountPeople.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.isNotEmpty && int.tryParse(value) != null) {
                  context.read<AddProductBloc>().add(
                    DiscountValuesEvent(peopleNumber: int.parse(value)),
                  );
                }
              },
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
