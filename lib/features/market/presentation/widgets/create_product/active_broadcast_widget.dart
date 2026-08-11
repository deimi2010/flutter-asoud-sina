import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';

class ActiveBroadcastWidget extends StatelessWidget {
  const ActiveBroadcastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        return Container(
          height: Dimensions.height * 0.07,
          decoration: BoxDecoration(
            color: Colora.lightBlue,
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.symmetric(vertical: Dimensions.height * 0.02),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Dimensions.width * 0.4,
                child: CheckboxListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'نمایش در نیازمندی',
                        style: TextStyle(
                          color: Colora.scaffold,
                          fontSize: Dimensions.width * 0.035,
                        ),
                      ),
                    ),
                  ),
                  value: state.isRequirement,
                  onChanged: (newValue) {
                    context.read<AddProductBloc>().add(
                      SetIsRequirementEvent(
                        isRequirement: !state.isRequirement,
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(color: Colora.scaffold),
                  fillColor: WidgetStateProperty.all(Colora.scaffold),
                  activeColor: Colora.scaffold,
                  checkColor: Colora.primaryColor,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              SizedBox(
                width: Dimensions.width * 0.4,
                child: CheckboxListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'نیاز به بازاریابی ویژه',
                        style: TextStyle(
                          color: Colora.scaffold,
                          fontSize: Dimensions.width * 0.035,
                        ),
                      ),
                    ),
                  ),
                  value: state.isMarketer,
                  onChanged: (newValue) {
                    context.read<AddProductBloc>().add(
                      SetIsMarketerEvent(isMarketer: !state.isMarketer),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(color: Colora.scaffold),
                  activeColor: Colora.scaffold,
                  fillColor: WidgetStateProperty.all(Colora.scaffold),
                  checkColor: Colora.primaryColor,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
