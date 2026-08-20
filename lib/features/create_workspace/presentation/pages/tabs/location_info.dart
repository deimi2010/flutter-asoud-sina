import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/helper/validators.dart';
import 'package:asood/core/models/location_model.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:asood/core/widgets/map_widget_2.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/create_workspace/presentation/widgets/location_dialog.dart';
import 'package:asood/features/create_workspace/presentation/widgets/payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

enum _LocationSelection { country, province, city }

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
  bool _waitingForDraftCompletion = false;
  _LocationSelection? _pendingSelection;
  String _openedPaymentUrl = '';

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CreateWorkSpaceBloc>(context);
    void restore(CreateWorkSpaceState state) {
      addressController.text = state.address;
      zipCodeController.text = state.postalCode;
    }

    if (bloc.state.isDraftLoaded) {
      restore(bloc.state);
    } else {
      bloc.stream.firstWhere((state) => state.isDraftLoaded).then((state) {
        if (mounted) restore(state);
      });
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

  void _showLocationSelector(
    BuildContext context,
    CreateWorkSpaceState state,
    _LocationSelection selection,
  ) {
    final title = switch (selection) {
      _LocationSelection.country => 'کشور',
      _LocationSelection.province => 'استان',
      _LocationSelection.city => 'شهر',
    };
    final items = switch (selection) {
      _LocationSelection.country => state.countryList,
      _LocationSelection.province => state.provinceList,
      _LocationSelection.city => state.cityList,
    };

    LocationDialog.showLocationSelector(
      title: title,
      context: context,
      items: items,
      getName: (item) => item.name ?? '',
      getId: (item) => item.id,
      onSelect: (item) {
        switch (selection) {
          case _LocationSelection.country:
            bloc.add(
              ChangeLocDataEvent(
                country: item.name ?? '',
                countryId: item.id ?? '',
                province: '',
                provinceId: '',
                city: '',
                cityId: '',
              ),
            );
            return;
          case _LocationSelection.province:
            bloc.add(
              ChangeLocDataEvent(
                province: item.name ?? '',
                provinceId: item.id ?? '',
                city: '',
                cityId: '',
              ),
            );
            return;
          case _LocationSelection.city:
            bloc.add(
              ChangeLocDataEvent(city: item.name ?? '', cityId: item.id ?? ''),
            );
            return;
        }
      },
    );
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
              child: BlocConsumer<CreateWorkSpaceBloc, CreateWorkSpaceState>(
                listener: (context, state) {
                  if (_waitingForDraftCompletion &&
                      state.submitStatus == WorkspaceSubmitStatus.success) {
                    _waitingForDraftCompletion = false;
                    if (state.isEditing) {
                      final message =
                          state.syncStatus == WorkspaceSyncStatus.localOnly
                          ? '\u062a\u063a\u06cc\u06cc\u0631\u0627\u062a \u0628\u0647 \u0635\u0648\u0631\u062a \u0645\u062d\u0644\u06cc \u0630\u062e\u06cc\u0631\u0647 \u0634\u062f\u061b \u067e\u0633 \u0627\u0632 \u0628\u0631\u0642\u0631\u0627\u0631\u06cc \u0627\u0631\u062a\u0628\u0627\u0637 \u062f\u0648\u0628\u0627\u0631\u0647 \u0630\u062e\u06cc\u0631\u0647 \u06a9\u0646\u06cc\u062f.'
                          : '\u062a\u063a\u06cc\u06cc\u0631\u0627\u062a \u0630\u062e\u06cc\u0631\u0647 \u0648 \u0628\u0631\u0627\u06cc \u062a\u0623\u06cc\u06cc\u062f \u0627\u0631\u0633\u0627\u0644 \u0634\u062f.';
                      showSnackBar(context, message);
                      Navigator.of(context).pop(true);
                    } else {
                      paymentDialog(context);
                    }
                  }
                  if (state.regionLoadStatus == RegionLoadStatus.success &&
                      _pendingSelection != null) {
                    final selection = _pendingSelection!;
                    _pendingSelection = null;
                    _showLocationSelector(context, state, selection);
                  }
                  if (state.paymentStatus ==
                          SubscriptionPaymentStatus.pending &&
                      state.paymentRedirectUrl.isNotEmpty &&
                      state.paymentRedirectUrl != _openedPaymentUrl) {
                    _openedPaymentUrl = state.paymentRedirectUrl;
                    launchUrl(
                      Uri.parse(state.paymentRedirectUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //country
                        const SizedBox(height: 15),
                        CustomButton(
                          onPress: () {
                            if (state.countryList.isNotEmpty) {
                              _showLocationSelector(
                                context,
                                state,
                                _LocationSelection.country,
                              );
                            } else {
                              _pendingSelection = _LocationSelection.country;
                              widget.bloc.add(LoadCountry());
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
                            } else if (state.provinceList.isNotEmpty) {
                              _showLocationSelector(
                                context,
                                state,
                                _LocationSelection.province,
                              );
                            } else {
                              _pendingSelection = _LocationSelection.province;
                              widget.bloc.add(
                                LoadProvince(countryId: state.countryId),
                              );
                            }
                          },
                          width: Dimensions.width * 0.88,
                          height: Dimensions.height * 0.05,
                          color: Colors.white,
                          text: state.province.isEmpty
                              ? "استان"
                              : state.province,
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
                            } else if (state.cityList.isNotEmpty) {
                              _showLocationSelector(
                                context,
                                state,
                                _LocationSelection.city,
                              );
                            } else {
                              _pendingSelection = _LocationSelection.city;
                              widget.bloc.add(
                                LoadCity(provinceId: state.provinceId),
                              );
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
                          keyboardType: TextInputType.streetAddress,
                          onChanged: (value) =>
                              bloc.add(UpdateWorkspaceDraft(address: value)),
                        ),
                        const SizedBox(height: 7),

                        //zipcode
                        CustomTextField(
                          controller: zipCodeController,
                          text: "کد پستی",
                          maxLength: 10,
                          validator: Validators.post,
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              bloc.add(UpdateWorkspaceDraft(postalCode: value)),
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
                                showInitialMarker:
                                    state.latitude.isNotEmpty &&
                                    state.longitude.isNotEmpty,
                                initialLocation: LocationModel(
                                  lat:
                                      double.tryParse(state.latitude) ??
                                      35.6783,
                                  lon:
                                      double.tryParse(state.longitude) ??
                                      51.4161,
                                ),
                                selectedLocation: (mapLocation) {
                                  bloc.add(
                                    ChangeLocDataEvent(
                                      latitude: mapLocation.latitude.toString(),
                                      longitude: mapLocation.longitude
                                          .toString(),
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
                                      const PreviousWorkspaceStep(),
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

                                    if (!_formKey.currentState!.validate() ||
                                        state.cityId.isEmpty ||
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
                                      _waitingForDraftCompletion = true;
                                      widget.bloc.add(
                                        SaveMarketLocationEvent(
                                          address: addressController.text
                                              .trim(),
                                          postalCode: zipCodeController.text
                                              .trim(),
                                        ),
                                      );
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
