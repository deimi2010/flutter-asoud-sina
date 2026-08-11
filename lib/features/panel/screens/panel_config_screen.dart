import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:flutter/material.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/custom_button.dart';

import 'package:asood/core/widgets/search_box.dart';
import 'package:asood/core/widgets/simple_bot_navbar.dart';

class PanelConfigScreen extends StatefulWidget {
  const PanelConfigScreen({super.key});

  @override
  State<PanelConfigScreen> createState() => _PanelConfigScreenState();
}

class _PanelConfigScreenState extends State<PanelConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: DefaultAppBar(context: context, title: '',),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.height * 0.11),
                      const SelectPanel(),
                      const SizedBox(height: 10),
                      const SendBulkMessage(),
                      const SizedBox(height: 10),
                      const SelectContacts(),
                      const SizedBox(height: 10),
                      const SetMessage(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 150,
                            margin: const EdgeInsets.all(10.0),
                            child: CustomButton(
                              onPress: () {},
                              text: "ذخیره",
                              textColor: Colora.scaffold,
                              fontWeight: FontWeight.bold,
                              color: Colora.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SimpleBotNavBar(),
                    ],
                  ),
                ),
              ),
              const NewAppBar(title: 'پنل پیامک'),
            ],
          ),
          // bottomNavigationBar: const SimpleBotNavBar(),
        ),
      ),
    );
  }
}

class SelectPanel extends StatefulWidget {
  const SelectPanel({super.key});

  @override
  State<SelectPanel> createState() => _SelectPanelState();
}

class _SelectPanelState extends State<SelectPanel> {
  String _groupValue = 'initialValue';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colora.primaryColor,
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              'انتخاب پنل',
              style: TextStyle(
                color: Colora.scaffold,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(thickness: 1, color: Colors.white),
          const SizedBox(height: 20),
          const Text(
            'شما می‌توانید پنل مورد نیاز جهت ارسال پیام را انتخاب کنید:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colora.scaffold,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          selectPanelType(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onPress: () {},
                text: 'انتخاب',
                width: Dimensions.width * 0.4,
              ),
              CustomButton(
                onPress: () {},
                text: 'انصراف',
                width: Dimensions.width * 0.4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container selectPanelType() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colora.lightBlue,
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height * 0.01,
        horizontal: Dimensions.width * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              'پنل آسود',
              style: TextStyle(color: Colora.scaffold, fontSize: 14),
            ),
          ),
          Expanded(
            child: Radio(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStateProperty.all(Colora.scaffold),
              groupValue: _groupValue,
              value: 'firstOption',
              onChanged:
                  (value) => setState(() => _groupValue = value ?? _groupValue),
            ),
          ),

          SizedBox(width: Dimensions.width * 0.1),
          // radioButton(
          //   title: 'پنل آسود',
          //
          //   groupValue: _groupValue,
          //   value: 'firstOption',
          //   onChanged: (value) =>
          //       setState(() => _groupValue = value ?? _groupValue),
          // ),
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              'پنل شخصی',
              style: TextStyle(color: Colora.scaffold, fontSize: 14),
            ),
          ),
          Expanded(
            child: Radio(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStateProperty.all(Colora.scaffold),
              groupValue: _groupValue,
              value: 'firstOption',
              onChanged:
                  (value) => setState(() => _groupValue = value ?? _groupValue),
            ),
          ),
          // radioButton(
          //   title: 'پنل شخصی',
          //   groupValue: _groupValue,
          //   value: 'secondOption',
          //   onChanged: (value) =>
          //       setState(() => _groupValue = value ?? _groupValue),
          // ),
        ],
      ),
    );
  }
}

class SendBulkMessage extends StatelessWidget {
  const SendBulkMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colora.primaryColor,
      ),
      child: Column(
        children: [
          const Text(
            'شما می‌توانید در اینجا پیام انبوه برای گروهی خاص یا مخاطبین خود ارسال نمایید : ',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colora.scaffold, fontSize: 12),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onPress: () {},
                width: Dimensions.width * 0.4,
                text: 'ارسال از اکسل',
              ),
              CustomButton(
                onPress: () {},
                width: 150,
                text: 'ارسال به مخاطبین',
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'با استفاده از دکمه‌های فوق می‌توانید از میان متن پیام‌های موجود متن مورد نظر خود را ارسال نمایید.',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colora.scaffold, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class SelectContacts extends StatefulWidget {
  const SelectContacts({Key? key}) : super(key: key);

  @override
  State<SelectContacts> createState() => _SelectContactsState();
}

class _SelectContactsState extends State<SelectContacts> {
  List<String> contacts = [
    'مخاطب نمونه ۱',
    'مخاطب نمونه ۲',
    'مخاطب نمونه ۳',
    'مخاطب نمونه ۴',
  ];

  List<bool> _isChecked = [];

  @override
  void initState() {
    super.initState();
    // Initialize all checkboxes to false initially
    _isChecked = List<bool>.filled(contacts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colora.primaryColor,
      ),
      child: Column(
        children: [
          Container(
            width: Dimensions.width,
            decoration: BoxDecoration(
              color: Colora.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: const SearchBoxWidget(backgroundColor: Colora.lightBlue),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colora.lightBlue,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'حمید احمدی',
                          style: TextStyle(
                            color: Colora.scaffold,
                            fontSize: Dimensions.width * 0.035,
                          ),
                        ),
                        Text(
                          '09123931774',
                          style: TextStyle(
                            color: Colora.scaffold,
                            fontSize: Dimensions.width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: _isChecked[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked[index] = value!;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: const BorderSide(color: Colora.scaffold),
                  fillColor: WidgetStateProperty.all(Colora.scaffold),
                  activeColor: Colora.scaffold,
                  checkColor: Colora.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                );
                // CheckboxListTile(
                //   title: Text(
                //     contacts[index],
                //     style: const TextStyle(color: Colora.scaffold),
                //   ),
                //   value: _isChecked[index],
                //   onChanged: (bool? value) {
                //     setState(() {
                //       _isChecked[index] = value!;
                //     });
                //   },
                //   controlAffinity: ListTileControlAffinity.leading,
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SetMessage extends StatelessWidget {
  const SetMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colora.primaryColor,
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              'متن پیامک',
              style: TextStyle(
                color: Colora.scaffold,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(thickness: 1, color: Colors.white),
          const Text(
            'لطفا متن پیام خود را در این قسمت وارد نمایید:',
            style: TextStyle(
              color: Colora.scaffold,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // CustomTextField(
          //   controller: TextEditingController(),
          //   text: 'متن پیام',
          //   maxLine: 8,
          // ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onPress: () {},
                width: Dimensions.width * 0.4,
                text: 'لغو',
              ),
              CustomButton(
                onPress: () {},
                width: Dimensions.width * 0.4,
                text: 'ثبت',
                textColor: Colora.scaffold,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
