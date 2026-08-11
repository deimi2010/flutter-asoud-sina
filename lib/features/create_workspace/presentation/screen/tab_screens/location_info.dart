import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/helper/validators.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:asood/core/widgets/map_widget_2.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/create_workspace/presentation/widgets/location_dialog.dart';
import 'package:asood/features/create_workspace/presentation/widgets/payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationInfo extends StatefulWidget {
  final CreateWorkSpaceBloc bloc;
  const LocationInfo({required this.bloc, super.key});

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
  final _formKey = GlobalKey<FormState>();

  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();

  late CreateWorkSpaceBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CreateWorkSpaceBloc>(context);

    bloc.add(LoadCountry());
  }

  @override
  void dispose() {
    addressController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.khorisontal),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Dimensions.width,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colora.primaryColor,
              ),
              child: BlocBuilder<CreateWorkSpaceBloc, CreateWorkSpaceState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //country
                        const SizedBox(height: 15),
                        CustomButton(
                          onPress: () {
                            widget.bloc.add(LoadCountry());
                            if (state.status == CWSStatus.success) {
                              LocationDialog.showLocationSelector(
                                title: "کشور",
                                context: context,
                                items: bloc.state.countryList,
                                getName: (item) => item.name ?? '',
                                getId: (item) => item.id,
                                onLoad: () {
                                  bloc.add(
                                    ChangeLocDataEvent(
                                      province: "",
                                      provinceId: "",
                                    ),
                                  );
                                },
                                onSelect: (item) {
                                  bloc.add(
                                    ChangeLocDataEvent(
                                      country: item.name!,
                                      countryId: item.id!,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          width: Dimensions.width * 0.88,
                          height: Dimensions.height * 0.05,
                          color: Colors.white,
                          text: state.country.isEmpty ? "کشور" : state.country,
                          textColor: Colora.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),

                        //province
                        const SizedBox(height: 7),
                        CustomButton(
                          onPress: () {
                            if (state.countryId.isEmpty) {
                              showSnackBar(
                                context,
                                "لطفا ابتدا کشور را انتخاب کنید",
                              );
                            } else if (state.status == CWSStatus.success) {
                              widget.bloc.add(
                                LoadProvince(countryId: state.countryId),
                              );
                              if (state.provinceList.isNotEmpty) {
                                LocationDialog.showLocationSelector(
                                  title: "استان",
                                  context: context,
                                  onLoad: () {
                                    bloc.add(
                                      ChangeLocDataEvent(
                                        province: "",
                                        provinceId: "",
                                      ),
                                    );
                                  },
                                  items: bloc.state.provinceList,
                                  getName: (item) => item.name ?? '',
                                  getId: (item) => item.id,

                                  onSelect: (item) {
                                    bloc.add(
                                      ChangeLocDataEvent(
                                        province: item.name!,
                                        provinceId: item.id!,
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                          width: Dimensions.width * 0.88,
                          height: Dimensions.height * 0.05,
                          color: Colors.white,
                          text:
                              state.province.isEmpty ? "استان" : state.province,
                          textColor: Colora.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),

                        //city
                        const SizedBox(height: 7),
                        CustomButton(
                          onPress: () {
                            if (state.provinceId.isEmpty) {
                              showSnackBar(
                                context,
                                "لطفا ابتدا استان را انتخاب کنید",
                              );
                            } else if (state.status == CWSStatus.success) {
                              widget.bloc.add(
                                LoadCity(provinceId: state.provinceId),
                              );
                              if (state.cityList.isNotEmpty) {
                                LocationDialog.showLocationSelector(
                                  title: "شهر",
                                  context: context,
                                  onLoad: () {
                                    bloc.add(
                                      ChangeLocDataEvent(city: "", cityId: ""),
                                    );
                                  },
                                  items: bloc.state.cityList,
                                  getName: (item) => item.name ?? '',
                                  getId: (item) => item.id,
                                  onSelect: (item) {
                                    bloc.add(
                                      ChangeLocDataEvent(
                                        city: item.name!,
                                        cityId: item.id!,
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                          width: Dimensions.width * 0.88,
                          height: Dimensions.height * 0.05,
                          color: Colors.white,
                          text: state.city.isEmpty ? "شهر" : state.city,
                          textColor: Colora.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 7),
                        // address
                        CustomTextField(
                          maxLine: 6,
                          controller: addressController,
                          text: "آدرس فروشگاه",
                        ),
                        const SizedBox(height: 7),

                        //zipcode
                        CustomTextField(
                          controller: zipCodeController,
                          text: "کد پستی",
                          maxLength: 10,
                          validator: Validators.post,
                        ),

                        //location picker
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 7,
                          ),
                          height: 220,

                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: MapScreen(
                                isSelecting: true,
                                selectedLocation: (mapLocation) {
                                  bloc.add(
                                    ChangeLocDataEvent(
                                      latitude: mapLocation.latitude.toString(),
                                      longitude:
                                          mapLocation.longitude.toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // LocationPicker(),
                          ),
                        ),
                        const SizedBox(height: 7),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //back
                                CustomButton(
                                  width: 100,
                                  onPress: () {
                                    widget.bloc.add(
                                      ChangeWorkspaceTabView(activeTabIndex: 1),
                                    );
                                  },
                                  text: "قبلی",
                                  color: Colors.white,
                                  textColor: Colora.primaryColor,
                                  height: 40,
                                ),
                                const SizedBox(width: 5),

                                //submit
                                CustomButton(
                                  width: 100,
                                  onPress: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    if (state.cityId.isEmpty ||
                                        addressController.text.isEmpty) {
                                      showSnackBar(
                                        context,
                                        "لطفا فیلدها را پر کنید",
                                      );
                                    } else if (state.latitude.isEmpty ||
                                        state.longitude.isEmpty) {
                                      showSnackBar(
                                        context,
                                        "لوکیشن را انتخاب کنید",
                                      );
                                    } else {
                                      widget.bloc.add(
                                        SaveMarketLocationEvent(),
                                      );

                                      if (widget.bloc.state.status ==
                                          CWSStatus.success) {
                                        paymentDialog(context);
                                      }
                                    }
                                  },
                                  text: "ثبت",
                                  color: Colors.white,
                                  textColor: Colora.primaryColor,
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
