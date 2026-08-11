import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/job_managment/data/model/category_model.dart';
import 'package:asood/features/job_managment/presentation/bloc/jobmanagment_bloc.dart';
import 'package:asood/features/job_managment/presentation/widgets/category_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asood/core/constants/constants.dart';

import 'package:asood/core/widgets/custom_button.dart';

class CatTab extends StatefulWidget {
  final JobmanagmentBloc bloc;
  const CatTab({required this.bloc, super.key});

  @override
  State<CatTab> createState() => _CatTabState();
}

class _CatTabState extends State<CatTab> {
  String selectedCategoryId = "0";

  late JobmanagmentBloc catBloc;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<JobmanagmentBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.khorisontal),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<JobmanagmentBloc, JobmanagmentState>(
              listener: (context, state) {
                if (state.status == CWSStatus.failure) {
                  showSnackBar(context, "مشکلی پیش آمده مجددا تلاش کنید");
                }
              },
              builder: (context, state) {
                if (state.status == CWSStatus.success) {
                  return Container(
                    width: Dimensions.width,

                    margin: EdgeInsets.only(bottom: Dimensions.height * 0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colora.primaryColor,
                    ),

                    padding: EdgeInsets.all(Dimensions.height * 0.01),
                    child: CategoryBuilder(
                      state: state,
                      onItemTap: (index) {
                        CategoryModel selectedCategory =
                            state.mainSubCategoryList[index];
                        bloc.add(
                          ChangeCategoryIndex(
                            activeCategoryId: selectedCategory.id!,
                          ),
                        );
                        bloc.add(ChangeTabView(activeTabIndex: 2));
                        bloc.add(
                          LoadSubCategory(subCategoryId: selectedCategory.id!),
                        );
                      },
                      categories: state.mainSubCategoryList,
                    ),
                  );
                }
                if (state.status == CWSStatus.failure) {
                  return Text(state.error);
                }
                return CircularProgressIndicator(color: Colors.white);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onPress: () {},
                  text:
                      BlocProvider.of<JobmanagmentBloc>(context).state.status ==
                              CWSStatus.loading
                          ? null
                          : "ویرایش",
                  color: Colora.primaryColor,
                  textColor: Colors.white,
                  height: 40,
                  width: 100,
                  btnWidget:
                      BlocProvider.of<JobmanagmentBloc>(context).state.status ==
                              CWSStatus.loading
                          ? const Center(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(),
                            ),
                          )
                          : null,
                ),
                CustomButton(
                  onPress: () {},
                  text:
                      BlocProvider.of<JobmanagmentBloc>(context).state.status ==
                              CWSStatus.loading
                          ? null
                          : "افزودن دسته",
                  color: Colora.primaryColor,
                  textColor: Colors.white,
                  height: 40,
                  width: 100,
                  btnWidget:
                      BlocProvider.of<JobmanagmentBloc>(context).state.status ==
                              CWSStatus.loading
                          ? const Center(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(),
                            ),
                          )
                          : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
