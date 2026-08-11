import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

void showCustomFormDialog(BuildContext context) {
  final TextEditingController valueController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: EdgeInsets.all(8),
        backgroundColor: Colora.scaffold,

        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "تغریف دسته",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colora.primaryColor,
                ),
              ),
              Divider(color: Colora.primaryColor),
              SizedBox(height: 10),
              Text(
                "لطفا عنوان را وارد نمایید...",
                style: TextStyle(fontSize: 15, color: Colora.primaryColor),
              ),
              Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.khorisontal,
                ),
                decoration: BoxDecoration(
                  color: Colora.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.twenty),
                ),
                child: Text(
                  "گزینه را انتخاب کنید...",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  controller: valueController,
                  text: "اینجا وارد نمایید...",
                  padding: EdgeInsets.zero,
                  hintStyle: TextStyle(color: Colors.white),
                  color: Colora.primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "هزینه اشتراک گروه",
                style: TextStyle(fontSize: 15, color: Colora.primaryColor),
              ),
              Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.khorisontal,
                ),
                decoration: BoxDecoration(
                  color: Colora.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.twenty),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Center(
                        child: Text(
                          "500/000",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Text("تومان", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                spacing: 5,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 50,
                      child: CustomButton(onPress: () {}, text: "لغو"),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 50,
                      child: CustomButton(onPress: () {}, text: "ثبت"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
