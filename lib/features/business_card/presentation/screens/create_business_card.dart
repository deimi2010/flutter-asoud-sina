// import 'package:asood/core/constants/constants.dart';
// import 'package:asood/core/widgets/appbar/default_appbar.dart';
// import 'package:asood/core/widgets/custom_button.dart';
// import 'package:asood/core/widgets/custom_textfield.dart';
// import 'package:asood/core/widgets/radio_button.dart';
// import 'package:asood/features/business_card/presentation/widgets/map_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CreateBusinessCard extends StatefulWidget {
//   final bool isEdit;
//   const CreateBusinessCard({super.key, required this.isEdit});

//   @override
//   State<CreateBusinessCard> createState() => _CreateBusinessCardState();
// }

// class _CreateBusinessCardState extends State<CreateBusinessCard> {
//   // Define a variable to track the current selection
//   String _selectedType = 'corporation';
//   // Variable to keep track of the selected job title
//   // String? _selectedJobTitle; // Variable to keep track of the selected job title
//   // final List<String> _jobTitles = [
//   //   'Software Developer',
//   //   'Product Manager',
//   //   'Graphic Designer',
//   // ];

//   String name = '';
//   String description = '';
//   String slogan = '';
//   String phone = '';
//   String mobile = '';
//   String email = '';
//   String website = '';
//   String telegram = '';
//   String instagram = '';
//   String country = '';
//   String city = '';
//   String province = '';
//   String adderess = '';
//   String post = '';

//   void editVisitCard() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     List? data = sharedPreferences.getStringList('visit_card');

//     if (data != null) {
//       setState(() {
//         name = data[1];
//         description = data[2];
//         slogan = data[3];
//         phone = data[4];
//         mobile = data[5];
//         email = data[6];
//         website = data[7];
//         telegram = data[8];
//         instagram = data[9];
//         country = data[10];
//         city = data[11];
//         province = data[12];
//         adderess = data[13];
//         post = data[14];
//       });
//     }
//   }

//   void saveVisitCard() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setStringList('visit_card', [
//       _selectedType,
//       name,
//       description,
//       slogan,
//       phone,
//       mobile,
//       email,
//       website,
//       telegram,
//       instagram,
//       country,
//       city,
//       province,
//       adderess,
//       post,
//     ]);
//   }

//   @override
//   void initState() {
//     if (widget.isEdit) {
//       editVisitCard();
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colora.primaryColor,
//       child: SafeArea(
//         child: Scaffold(
//           // appBar: DefaultAppBar(context: context, title: ''),
//           body: Stack(
//             children: [
//               SingleChildScrollView(
//                 child: Container(
//                   margin: EdgeInsets.fromLTRB(
//                     Dimensions.width * 0.05,
//                     Dimensions.height * 0.12,
//                     Dimensions.width * 0.05,
//                     Dimensions.height * 0.05,
//                   ),
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colora.primaryColor,
//                   ),
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       //type
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           radioButton(
//                             title: 'شرکتی',
//                             groupValue:
//                                 _selectedType, // Use the _selectedType variable here
//                             value: 'corporation',
//                             onChanged: (value) {
//                               // Update the _selectedType variable when the radio button is selected
//                               setState(() {
//                                 _selectedType = value!;
//                               });
//                             },
//                           ),
//                           radioButton(
//                             title: 'فروشگاهی',
//                             groupValue: _selectedType, // And here
//                             value: 'shop',
//                             onChanged: (value) {
//                               // And also here
//                               setState(() {
//                                 _selectedType = value!;
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       //category
//                       Container(
//                         width: Dimensions.width,
//                         height: Dimensions.height * 0.065,
//                         margin: EdgeInsets.symmetric(
//                           horizontal: Dimensions.width * 0.03,
//                         ),
//                         // padding: const EdgeInsets.symmetric(horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.white, // Dropdown background color
//                           borderRadius: BorderRadius.circular(
//                             20,
//                           ), // Curved edges
//                         ),
//                         child: MaterialButton(
//                           onPressed: () {},
//                           child: const Text(
//                             'انتخاب شغل',
//                             style: TextStyle(
//                               color: Colora.primaryColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         // DropdownButton<String>(
//                         //   isExpanded: true,
//                         //   value: _selectedJobTitle,
//                         //   hint: const Text('Select job title'),
//                         //   onChanged: (String? newValue) {
//                         //     setState(() {
//                         //       _selectedJobTitle = newValue;
//                         //     });
//                         //   },
//                         //   items: _jobTitles
//                         //       .map<DropdownMenuItem<String>>((String value) {
//                         //     return DropdownMenuItem<String>(
//                         //       value: value,
//                         //       child: Center(
//                         //         child: Container(
//                         //           decoration: BoxDecoration(
//                         //             // color: Colors.white, // Menu item background color
//                         //             borderRadius: BorderRadius.circular(
//                         //                 25), // Curved edges for menu items
//                         //           ),
//                         //           child: Text(value),
//                         //         ),
//                         //       ),
//                         //     );
//                         //   }).toList(),
//                         //   underline: Container(), // Removes the default underline
//                         //   dropdownColor: Colors
//                         //       .white, // Background color for the dropdown items
//                         // ),
//                       ),
//                       const SizedBox(height: 20),
//                       //name
//                       CustomTextField(
//                         controller: TextEditingController(text: name),
//                         text: 'نام کسب و کار: ',
//                         onChanged: (value) {
//                           // setState(() {
//                           name = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       //description
//                       CustomTextField(
//                         controller: TextEditingController(text: description),
//                         text: 'توضیحات',
//                         maxLine: 6,
//                         onChanged: (value) {
//                           // setState(() {
//                           description = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: slogan),
//                         text: 'شعار تبلیغاتی',
//                         onChanged: (value) {
//                           // setState(() {
//                           slogan = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: phone),
//                         text: 'شماره تماس',
//                         onChanged: (value) {
//                           // setState(() {
//                           phone = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: mobile),
//                         text: 'شماره همراه',
//                         onChanged: (value) {
//                           // setState(() {
//                           mobile = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: email),
//                         text: 'ایمیل',
//                         onChanged: (value) {
//                           // setState(() {
//                           email = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: website),
//                         text: 'سایت',
//                         onChanged: (value) {
//                           // setState(() {
//                           website = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: telegram),
//                         text: 'تلگرام',
//                         onChanged: (value) {
//                           // setState(() {
//                           telegram = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: instagram),
//                         text: 'اینستاگرام',
//                         onChanged: (value) {
//                           // setState(() {
//                           instagram = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: country),
//                         text: 'کشور',
//                         onChanged: (value) {
//                           // setState(() {
//                           country = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: province),
//                         text: 'استان',
//                         onChanged: (value) {
//                           // setState(() {
//                           province = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: city),
//                         text: 'شهر',
//                         onChanged: (value) {
//                           // setState(() {
//                           city = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: adderess),
//                         text: 'آدرس',
//                         maxLine: 4,
//                         onChanged: (value) {
//                           // setState(() {
//                           adderess = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: TextEditingController(text: post),
//                         text: 'کد پستی',
//                         onChanged: (value) {
//                           // setState(() {
//                           post = value;
//                           // });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 7,
//                           horizontal: 7,
//                         ),
//                         height: 220,
//                         child: const Center(
//                           child: LocationPicker(), //Text("map"),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CustomButton(
//                             onPress: () {},
//                             text: 'تنظیمات رنگ',
//                             width: Dimensions.width * 0.35,
//                             color: Colors.white,
//                             textColor: Colora.primaryColor,
//                           ),
//                           CustomButton(
//                             onPress: () {
//                               // saveVisitCard();

//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) => const BusinessCard(),
//                               //   ),
//                               // );
//                             },
//                             text: 'ثبت',
//                             width: Dimensions.width * 0.35,
//                             color: Colors.white,
//                             textColor: Colora.primaryColor,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const NewAppBar(title: 'ثبت کار ویزیت'),
//             ],
//           ),
//           // ... rest of the code
//         ),
//       ),
//     );
//   }
// }
