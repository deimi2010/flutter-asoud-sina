import 'package:asood/core/helper/validators.dart';
import 'package:asood/features/create_workspace/data/models/market_contact.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/create_workspace/presentation/widgets/custom_switch.dart';
import 'package:asood/features/create_workspace/presentation/widgets/socialmedia_listbuilder.dart';
import 'package:asood/features/create_workspace/presentation/widgets/socialmedia_selector.dart';
import 'package:asood/features/create_workspace/presentation/widgets/weekday_opentime.dart';
import 'package:asood/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

import 'package:asood/core/constants/constants.dart';

import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsInfo extends StatefulWidget {
  const ContactsInfo({required this.bloc, super.key});

  final CreateWorkSpaceBloc bloc;

  @override
  State<ContactsInfo> createState() => _ContactsInfoState();
}

class _ContactsInfoState extends State<ContactsInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController phone1Controller = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController telegramController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  //work time textcontrollers
  TextEditingController satFController = TextEditingController();
  TextEditingController satTController = TextEditingController();

  TextEditingController sunFController = TextEditingController();
  TextEditingController sunTController = TextEditingController();

  TextEditingController monFController = TextEditingController();
  TextEditingController monTController = TextEditingController();

  TextEditingController tueFController = TextEditingController();
  TextEditingController tueTController = TextEditingController();

  TextEditingController wedFController = TextEditingController();
  TextEditingController wedTController = TextEditingController();

  TextEditingController thuFController = TextEditingController();
  TextEditingController thuTController = TextEditingController();

  TextEditingController friFController = TextEditingController();
  TextEditingController friTController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final workspaceBloc = context.read<CreateWorkSpaceBloc>();
    void restore(CreateWorkSpaceState state) {
      phone1Controller.text =
          state.phoneNumber1.isNotEmpty
              ? state.phoneNumber1
              : context.read<AuthBloc>().state.phoneNumber;
      phone2Controller.text = state.phoneNumber2;
      phoneNumberController.text = state.telephone;
      faxController.text = state.fax;
      emailController.text = state.email;
      siteController.text = state.websiteUrl;
    }

    if (workspaceBloc.state.isDraftLoaded) {
      restore(workspaceBloc.state);
    } else {
      workspaceBloc.stream.firstWhere((state) => state.isDraftLoaded).then((
        state,
      ) {
        if (mounted) restore(state);
      });
    }
  }

  @override
  void dispose() {
    phone1Controller.dispose();
    phone2Controller.dispose();
    phoneNumberController.dispose();
    faxController.dispose();
    emailController.dispose();
    siteController.dispose();
    telegramController.dispose();
    instaController.dispose();
    super.dispose();
  }

  List<MapEntry<String, String>> messengerListFromIds(MessengerIds ids) {
    return {
          'telegram': ids.telegram,
          'whatsapp': ids.whatsapp,
          'instagram': ids.instagram,
          'eita': ids.eita,
        }.entries
        .where((entry) => entry.value != null && entry.value!.isNotEmpty)
        .map((e) => MapEntry(e.key, e.value!))
        .toList();
  }

  submit() {
    bool isEmptySchedule = false;
    if (widget.bloc.state.hasWorkTime) {
      isEmptySchedule =
          widget.bloc.state.marketSchedules.isEmpty ||
          widget.bloc.state.marketSchedules.any(
            (schedule) => schedule.end == null || schedule.end!.isEmpty,
          );
    }
    if (_formKey.currentState!.validate() && isEmptySchedule == false) {
      widget.bloc.add(
        MarketContact(
          marketId: widget.bloc.state.marketId!,
          phoneNumber1: phone1Controller.text.trim(),
          phoneNumber2: phone2Controller.text.trim(),
          telephone: phoneNumberController.text.trim(),
          fax: faxController.text.trim(),
          email: emailController.text.trim(),
          websiteUrl: siteController.text.trim(),
          messengerIds: widget.bloc.state.messengerIds,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.khorisontal),
      child: SingleChildScrollView(
        child: Container(
          // height: Dimensions.height * .7,
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width * 0.01,
            vertical: Dimensions.height * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colora.primaryColor,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  isRequired: true,
                  controller: phone1Controller,
                  borderColor: widget.bloc.state.phoneBorder,
                  keyboardType: TextInputType.phone,
                  text: "شماره همراه 1",
                  maxLength: 11,
                  validator: (p0) => Validators.phoneNumber(p0),
                  onChanged:
                      (value) => widget.bloc.add(
                        UpdateWorkspaceDraft(phoneNumber1: value),
                      ),
                ),
                const SizedBox(height: 7),
                CustomTextField(
                  controller: phone2Controller,
                  text: "شماره همراه 2",
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  validator: (p0) => Validators.phoneNumber(p0, optional: true),
                  onChanged:
                      (value) => widget.bloc.add(
                        UpdateWorkspaceDraft(phoneNumber2: value),
                      ),
                ),
                const SizedBox(height: 7),
                CustomTextField(
                  controller: phoneNumberController,
                  text: "تلفن ثابت",
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  validator:
                      (p0) => Validators.landPhoneNumber(p0, optional: true),
                  onChanged:
                      (value) => widget.bloc.add(
                        UpdateWorkspaceDraft(telephone: value),
                      ),
                ),
                const SizedBox(height: 7),
                CustomTextField(
                  controller: faxController,
                  text: "فکس",
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  validator: (p0) => Validators.fax(p0, optional: true),
                  onChanged:
                      (value) =>
                          widget.bloc.add(UpdateWorkspaceDraft(fax: value)),
                ),
                const SizedBox(height: 7),
                CustomTextField(
                  borderColor: widget.bloc.state.emailBorder,
                  controller: emailController,
                  text: "ایمیل",
                  validator: (p0) => Validators.email(p0, optional: true),
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.ltr,
                  onChanged:
                      (value) =>
                          widget.bloc.add(UpdateWorkspaceDraft(email: value)),
                ),
                const SizedBox(height: 7),
                CustomTextField(
                  controller: siteController,
                  text: "سایت",
                  keyboardType: TextInputType.url,
                  validator: (p0) => Validators.website(p0, optional: true),
                  textDirection: TextDirection.ltr,
                  onChanged:
                      (value) => widget.bloc.add(
                        UpdateWorkspaceDraft(websiteUrl: value),
                      ),
                ),

                const SizedBox(height: 7),
                BlocBuilder<CreateWorkSpaceBloc, CreateWorkSpaceState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          showSocialSelectionDialog(
                            context,
                            onSubmit: (key, value) {
                              final updatedIds = state.messengerIds
                                  .copyWithByKey(key, value);

                              context.read<CreateWorkSpaceBloc>().add(
                                UpdateMessengerIds(updatedIds),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.khorisontal,
                          ),
                          decoration: BoxDecoration(
                            color: Colora.scaffold,
                            borderRadius: BorderRadius.circular(
                              Dimensions.twenty,
                            ),
                          ),
                          child: Text(
                            "انتخاب شبکه اجتماعی",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colora.primaryColor),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 7),
                SocialmediaListbuilder(),

                const SizedBox(height: 7),

                //time
                const Text(
                  "وارد کردن ساعت کاری باعث نمایش باز یا بسته بودن محل کار شما و جلب مشتری می شود.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                CustomSwitch(
                  title: "دارای ساعت کاری",
                  onChanged: (p0) {
                    widget.bloc.add(ChangeHasWorkTime(hasWorkTime: p0));
                  },
                  switchValue: widget.bloc.state.hasWorkTime,
                ),

                if (widget.bloc.state.hasWorkTime == true)
                  BlocBuilder<CreateWorkSpaceBloc, CreateWorkSpaceState>(
                    builder:
                        (context, state) => WeekdayOpentime(
                          marketId: widget.bloc.state.marketId!,
                        ),
                  ),

                SizedBox(height: Dimensions.height * 0.01),

                //button
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                        CustomButton(
                          onPress: () => submit(),
                          text:
                              BlocProvider.of<CreateWorkSpaceBloc>(
                                        context,
                                      ).state.draftSaveStatus ==
                                      DraftSaveStatus.saving
                                  ? null
                                  : "بعدی",
                          color: Colors.white,
                          textColor: Colora.primaryColor,
                          height: 40,
                          width: 100,
                          btnWidget:
                              BlocProvider.of<CreateWorkSpaceBloc>(
                                        context,
                                      ).state.draftSaveStatus ==
                                      DraftSaveStatus.saving
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
                  ),
                ),
                // SizedBox(height: Dimensions.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
