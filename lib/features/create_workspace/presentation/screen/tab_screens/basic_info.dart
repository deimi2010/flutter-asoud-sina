import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/helper/validators.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:asood/core/widgets/radio_button.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/create_workspace/presentation/widgets/simple_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// sina here we have to add things for getting data.

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController businessId = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController slogan = TextEditingController();
  final TextEditingController idCode = TextEditingController();

  bool isInProcess = false;
  String selectedCat = "";
  late CreateWorkSpaceBloc catBloc;

  @override
  void initState() {
    super.initState();
    catBloc = context.read<CreateWorkSpaceBloc>();
    catBloc.add(ChangeWorkspaceTabView(activeTabIndex: 0));
    catBloc.add(
      ChangeSelectedCategory(
        selectedCategoryName: 'انتخاب شغل',
        activeCategoryId: "",
      ),
    );
  }

  submit() {
    if (_formKey.currentState!.validate() &&
        catBloc.state.marketType.isNotEmpty &&
        catBloc.state.activeCategoryId != "") {
      catBloc.add(
        CreateMarket(
          businessId: businessId.text,
          name: name.text,
          description: description.text,
          slogan: slogan.text,
          idCode: idCode.text,
          marketType: catBloc.state.marketType,
          subCategory: catBloc.state.activeCategoryId,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colora.borderAvatar,
          content: Text(
            "لطفا تمامی فیلد های لازم را پر نمایید.",
            style: TextStyle(color: Colora.scaffold),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool isMarketTypeShop = catBloc.state.marketType == "shop";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.khorisontal),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //image
            Container(
              height: Dimensions.height * 0.25,
              width: Dimensions.width,
              padding: EdgeInsets.only(bottom: Dimensions.height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colora.primaryColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Assets.images.toolsThatYouShouldHave.image(
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 8),

            //text fields
            Container(
              width: Dimensions.width,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              margin: EdgeInsets.only(bottom: Dimensions.height * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colora.primaryColor,
              ),
              child: Form(
                key: _formKey,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SimpleTitle(title: 'انتخاب قالب'),

                    BlocBuilder<CreateWorkSpaceBloc, CreateWorkSpaceState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            radioButton(
                              title: "فروشگاهی",
                              value: "shop",
                              groupValue: state.marketType,
                              onChanged: (value) {
                                context.read<CreateWorkSpaceBloc>().add(
                                  SetMarketType(marketType: value!),
                                );
                              },
                            ),
                            radioButton(
                              title: "شرکتی",
                              value: "company",
                              groupValue: state.marketType,
                              onChanged: (value) {
                                context.read<CreateWorkSpaceBloc>().add(
                                  SetMarketType(marketType: value!),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 7),
                    CustomTextField(
                      controller: businessId,
                      isRequired: true,
                      text: "شناسه کاربری *",

                      // text: isMarketTypeShop ? "شناسه کسب و کار" : "شناسه شرکت",
                      validator: Validators.simpleFieldEmpty,
                      keyboardType: TextInputType.visiblePassword,
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.allow(RegExp('[0-9۰-۹]')),
                      // ],

                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(
                      //     RegExp(r'[a-zA-Z0-9\s]'),
                      //   ),
                      // ],
                    ),
                    const SizedBox(height: 7),
                    CustomTextField(
                      isRequired: true,
                      controller: name,
                      text: isMarketTypeShop ? "نام کسب و کار *" : "نام شرکت *",
                      validator: Validators.simpleFieldEmpty,
                    ),
                    const SizedBox(height: 7),
                    CustomTextField(
                      isRequired: true,
                      controller: description,
                      text: "توضیحات",
                      maxLine: 6,
                      validator: Validators.simpleFieldEmpty,
                    ),
                    const SizedBox(height: 7),
                    CustomTextField(
                      isRequired: true,
                      controller: slogan,
                      text: "شعار تبلیغاتی",
                      // text: isMarketTypeShop ? "شعار تبلیغاتی" : "شعار شرکت",
                      validator: Validators.simpleFieldEmpty,
                    ),
                    const SizedBox(height: 7),
                    CustomTextField(
                      maxLength: isMarketTypeShop ? 10 : 11,
                      keyboardType: TextInputType.number,
                      controller: idCode,
                      text: isMarketTypeShop ? "کد ملی *" : "شناسه ملی *",
                      validator:
                          isMarketTypeShop
                              ? Validators.iranianNationalCodeValidator
                              : Validators.companyValidation,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "کد ملی صرفا جهت تخصیص آگهی به شما میباشد",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    BlocBuilder<CreateWorkSpaceBloc, CreateWorkSpaceState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: Dimensions.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.twenty,
                            ),
                            color: Colora.scaffold,
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              final result = await context.push(
                                AppRoutes.jobManagement,
                              );

                              if (result is Map<String, String>) {
                                ChangeSelectedCategory(
                                  selectedCategoryName:
                                      result['selectedCategoryName'] ?? '',
                                  activeCategoryId:
                                      result['selectedCategoryId'] ?? '',
                                );
                              }
                            },
                            child: Text(
                              state.selectedCategoryName,
                              style: const TextStyle(
                                color: Colora.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child:
                            isInProcess
                                ? CustomButton(
                                  onPress: () async {
                                    if (businessId.text.isNotEmpty &&
                                        name.text.isNotEmpty &&
                                        description.text.isNotEmpty &&
                                        slogan.text.isNotEmpty &&
                                        idCode.text.isNotEmpty) {
                                    } else {
                                      if (!context.mounted) return;
                                      showSnackBar(
                                        context,

                                        "لطفا تمامی فیلد های لازم را پر نمایید.",
                                      );
                                    }
                                  },
                                  text:
                                      BlocProvider.of<CreateWorkSpaceBloc>(
                                                context,
                                              ).state.status ==
                                              CWSStatus.loading
                                          ? null
                                          : "ویرایش",
                                  color: Colors.white,
                                  textColor: Colora.primaryColor,
                                  height: 40,
                                  width: 100,
                                  btnWidget:
                                      BlocProvider.of<CreateWorkSpaceBloc>(
                                                context,
                                              ).state.status ==
                                              CWSStatus.loading
                                          ? const Center(
                                            child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                          : null,
                                )
                                : CustomButton(
                                  onPress: () => submit(),
                                  text:
                                      BlocProvider.of<CreateWorkSpaceBloc>(
                                                context,
                                              ).state.status ==
                                              CWSStatus.loading
                                          ? null
                                          : "بعدی",
                                  color: Colors.white,
                                  textColor: Colora.primaryColor,
                                  height: 40,
                                  width: 100,
                                  btnWidget:
                                      BlocProvider.of<CreateWorkSpaceBloc>(
                                                context,
                                              ).state.status ==
                                              CWSStatus.loading
                                          ? const Center(
                                            child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                          : null,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Dimensions.height * 0.25),
          ],
        ),
      ),
    );
  }
}
