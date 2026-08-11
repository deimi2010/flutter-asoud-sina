import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/job_managment/data/model/category_model.dart';
import 'package:asood/features/job_managment/presentation/bloc/jobmanagment_bloc.dart';
import 'package:asood/features/job_managment/presentation/widgets/category_builder.dart';

class SubTab extends StatefulWidget {
  final JobmanagmentBloc bloc;
  const SubTab({required this.bloc, super.key});

  @override
  State<SubTab> createState() => _SubTabState();
}

class _SubTabState extends State<SubTab> {
  String selectedCategoryId = "0";

  late JobmanagmentBloc catBloc;

  @override
  void initState() {
    super.initState();
  }

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
                            state.subCategoryList[index];
                        bloc.add(
                          ChangeCategoryIndex(
                            activeCategoryId: selectedCategory.id!,
                          ),
                        );
                        context.read<CreateWorkSpaceBloc>().add(
                          ChangeSelectedCategory(
                            selectedCategoryName: selectedCategory.title!,
                            activeCategoryId: selectedCategory.id!,
                          ),
                        );
                        context.pop({
                          'selectedCategoryName': selectedCategory.title!,
                          'selectedCategoryId': selectedCategory.id!,
                        });
                      },
                      categories: state.subCategoryList,
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
