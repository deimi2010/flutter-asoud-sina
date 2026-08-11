import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumber = context.select(
      (AuthBloc bloc) => bloc.state.phoneNumber,
    );

    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.success) {
                    context.go(AppRoutes.vendorHome);
                  } else if (state.status == AuthStatus.error) {
                    _showToast(
                      state.error == 'Pin not valid'
                          ? 'کد تایید اشتباه است'
                          : state.error,
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Spacer(),
                      _buildLogoSection(),
                      const SizedBox(height: 20),
                      _buildOtpField(context, phoneNumber),
                      const SizedBox(height: 20),
                      _buildSubmitButton(state, context, phoneNumber),
                      const Spacer(),
                      _buildFooter(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.height * 0.2,
          width: Dimensions.width,
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: Assets.images.asood.image(
                fit: BoxFit.scaleDown,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ),
        // Text(
        //   'آسود',
        //   style: TextStyle(fontSize: 55.0, color: Colors.blue.shade900),
        // ),
        Container(width: 150.0, height: 2, color: Colors.blue.shade900),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 100,
          color: Colors.blue.shade900,
        ),
        const SizedBox(height: 20),
        Text(
          'آسودگی خیال , با آسود',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'کد تایید',
          style: TextStyle(fontSize: 15.0, color: Colora.lightBlue),
        ),
      ],
    );
  }

  Widget _buildOtpField(BuildContext context, String phoneNumber) {
    return Container(
      width: Dimensions.width,
      padding: const EdgeInsets.only(bottom: 10),
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.2),
      decoration: BoxDecoration(
        color: Colora.primaryColor,
        borderRadius: BorderRadius.circular(28),
      ),
      height: Dimensions.height * 0.06,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: OtpTextField(
          enabledBorderColor: Colora.scaffold,
          borderColor: const Color(0xFF512DA8),
          cursorColor: Colora.scaffold,
          textStyle: const TextStyle(color: Colora.scaffold),
          showFieldAsBox: false,
          onSubmit: (String verificationCode) {
            context.read<AuthBloc>().add(
              VerifyOtp(phone: phoneNumber, otp: verificationCode),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
    AuthState state,
    BuildContext context,
    String phoneNumber,
  ) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colora.primaryColor),
      ),
      onPressed: () {
        _showToast(
          'کد تایید را وارد کنید',
        ); // در اینجا نیازی به بررسی مقدار OTP نیست چون در `_buildOtpField` ارسال شده است.
      },
      child:
          (state.status == AuthStatus.loading)
              ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white),
              )
              : const Text('ورود', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildFooter() {
    return CustomPaint(
      painter: CCurvedPainter(),
      child: SizedBox(
        height: 100,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "copyright",
                style: TextStyle(color: Colora.scaffold, fontSize: 13),
              ),
            ),
            Center(
              child: Text(
                "ASUD   2021",
                style: TextStyle(
                  color: Colora.scaffold,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
