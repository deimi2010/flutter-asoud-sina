import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showSocialSelectionDialog(
  BuildContext context, {
  required Function(String key, String value) onSubmit,
  String? defaultKey,
  String? defaultValue,
}) {
  final TextEditingController valueController = TextEditingController(
    text: defaultValue ?? "",
  );
  String? selectedPlatform = defaultKey;

  final Map<String, String> platforms = {
    'telegram': 'تلگرام',
    'rubika': 'روبیکا',
    'eitaa': 'ایتا',
    'soroush': 'سروش',
    'bale': 'بله',
    'igap': 'ایگپ',
    'whatsapp': 'واتساپ',
    'instagram': 'اینستاگرام',
  };

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            contentPadding: EdgeInsets.all(16),
            backgroundColor: Colora.scaffold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.twenty),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "لطفاً شبکه اجتماعی را انتخاب کنید:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colora.primaryColor,
                    ),
                  ),
                  Divider(color: Colora.primaryColor),
                  SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    style: TextStyle(color: Colors.white),
                    hint: Text(
                      "انتخاب شبکه اجتماعی",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colora.primaryColor,

                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.twenty),
                      ),
                    ),
                    dropdownColor: Colora.primaryColor,
                    iconEnabledColor: Colors.white,
                    value: selectedPlatform,
                    items:
                        platforms.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(
                              entry.value,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPlatform = value;
                        valueController.clear();
                      });
                    },
                  ),

                  SizedBox(height: 16),

                  CustomTextField(
                    controller: valueController,
                    text:
                        selectedPlatform != null
                            ? "آیدی یا لینک ${platforms[selectedPlatform]}"
                            : "ابتدا شبکه اجتماعی را انتخاب کنید",
                    padding: EdgeInsets.zero,
                    hintStyle: TextStyle(color: Colors.white),
                    color: Colora.primaryColor,
                    enabled: selectedPlatform != null,
                    keyboardType: TextInputType.visiblePassword,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9\s]'),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CustomButton(
                            onPress: () => Navigator.pop(context),
                            text: "لغو",
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CustomButton(
                            onPress: () {
                              if (selectedPlatform != null &&
                                  valueController.text.trim().isNotEmpty) {
                                onSubmit(
                                  selectedPlatform!,
                                  valueController.text.trim(),
                                );
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'لطفاً همه فیلدها را کامل کنید.',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            text: "ثبت",
                          ),
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
    },
  );
}
