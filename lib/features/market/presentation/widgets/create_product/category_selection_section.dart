import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategorySelectionSection extends StatelessWidget {
  const CategorySelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        return Container(
          width: Dimensions.width,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
          decoration: BoxDecoration(
            color: Colora.scaffold,
            borderRadius: BorderRadius.circular(30),
          ),
          child: MaterialButton(
            onPressed: () async {
              final result = await context.push(AppRoutes.jobManagement);

              if (result is Map<String, String>) {
                if (context.mounted) {
                  context.read<AddProductBloc>().add(
                    SetCategoryEvent(
                      selectedCategoryName:
                          result['selectedCategoryName'] ?? '',
                      selectedCategoryId: result['selectedCategoryId'] ?? '',
                    ),
                  );
                }
              }
            },
            child: Text(
              state.selectedCategoryName != ''
                  ? state.selectedCategoryName
                  : 'انتخاب دسته بندی',
              style: TextStyle(
                color: Colora.primaryColor,
                fontSize: Dimensions.width * 0.034,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
