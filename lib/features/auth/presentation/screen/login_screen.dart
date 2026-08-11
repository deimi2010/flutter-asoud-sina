import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:asood/features/auth/presentation/screen/terms_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController controller = TextEditingController();

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colora.primaryColor,
        content: Text(message, style: const TextStyle(color: Colora.scaffold)),
      ),
    );
  }

  submit(BuildContext context, AuthState state) {
    String phone = controller.text.trim();
    if (!state.termStatus) {
      _showSnackBar(
        context,
        "بدون پذیرفتن قوانین و مقررات امکان استفاده از آسود نمیباشد!",
      );
    } else if (phone.isEmpty) {
      _showSnackBar(context, "لطفا شماره تلفن خود را وارد کنید");
    } else {
      context.read<AuthBloc>().add(SendOtp(phone: "0$phone"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colora.primaryColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Assets.images.login.image(fit: BoxFit.fill),

            /// لوگو
            Positioned(
              top: 30,
              right: Dimensions.width * 0.25,
              left: Dimensions.width * 0.25,
              height: Dimensions.height * 0.1,
              child: AspectRatio(
                aspectRatio: 1,
                child: Assets.images.asood.image(fit: BoxFit.scaleDown),
              ),
            ),

            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.success && state.termStatus) {
                  context.go(AppRoutes.otp);
                } else if (state.status == AuthStatus.error) {
                  _showSnackBar(context, "کد ارسال نشد");
                  debugPrint(state.error);
                }
              },
              builder: (context, state) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 145),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// checkbox
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.only(left: 5),
                              child: Checkbox(
                                activeColor: Colora.scaffold,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                checkColor: Colora.primaryColor,
                                side: const BorderSide(color: Colora.scaffold),
                                value: state.termStatus,
                                onChanged: (value) {
                                  context.read<AuthBloc>().add(
                                    ToggleTermsCheckboxEvent(isClicked: value!),
                                  );
                                },
                              ),
                            ),

                            Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap:
                                        () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    TermsAndConditions(),
                                          ),
                                        ),
                                    child: Text(
                                      'توافق نامه کاربری',
                                      style: TextStyle(
                                        color: Colora.lightBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  ' را خوانده قبول دارم',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// فیلد شماره تلفن
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            height: 50,
                            width: Dimensions.width * .8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: IntlPhoneField(
                              textAlign: TextAlign.start,
                              controller: controller,
                              searchText: "جستجو کشور",
                              languageCode: 'fa',
                              onSubmitted: (p0) => submit(context, state),
                              decoration: const InputDecoration(
                                counter: Offstage(),
                                hintTextDirection: TextDirection.rtl,

                                hintText: 'شماره تلفن:',
                                hintStyle: TextStyle(color: Colora.lightBlue),
                                hintFadeDuration: Duration.zero,
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                              ),
                              initialCountryCode: 'IR',
                              showCountryFlag: true,
                              autovalidateMode: AutovalidateMode.disabled,
                              dropdownIconPosition: IconPosition.trailing,
                              onChanged: (phone) {
                                debugPrint(phone.completeNumber);
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// دکمه ارسال کد تایید
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () => submit(context, state),
                          child: Container(
                            width: Dimensions.width * 0.25,
                            height: Dimensions.height * 0.04,
                            alignment: Alignment.center,
                            child:
                                state.status == AuthStatus.loading
                                    ? Transform.scale(
                                      scale: 0.6,
                                      child: const CircularProgressIndicator(
                                        color: Colora.primaryColor,
                                      ),
                                    )
                                    : const Text(
                                      "ارسال کد تایید",
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colora.primaryColor,
                                        fontWeight: FontWeight.bold,

                                        // fontSize: 15.0,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
