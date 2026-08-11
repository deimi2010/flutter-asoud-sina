import 'dart:convert';
import 'dart:io';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:asood/core/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/endpoints.dart';

class SubmitFeeInquiryScreen extends StatefulWidget {
  final bool isEdit;
  final String id;
  const SubmitFeeInquiryScreen({
    super.key,
    required this.isEdit,
    required this.id,
  });

  @override
  State<SubmitFeeInquiryScreen> createState() => _SubmitFeeInquiryScreenState();
}

class _SubmitFeeInquiryScreenState extends State<SubmitFeeInquiryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String type = 'good';
  String name = '';
  String description = '';
  String technicalDetails = '';
  String amount = '';
  String unit = '';
  String expiry = '';
  XFile image = XFile('');
  String lastImage = '';
  int date = 0;
  String send = '';

  var imageFile;

  void getLastData() async {
    String url = '${Endpoints.baseUrl}user/inquiries/${widget.id}/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    var data = jsonDecode(response.body)['data'];

    setState(() {
      type = data['type'];
      name = data['name'];
      technicalDetails = data['technical_detail'];
      amount = data['amount'];
      unit = data['unit'];
      expiry = data['expiry'].toString();
      lastImage =
          data['images'].isEmpty
              ? ''
              : 'https://asoud.ir${data['images'][0]['image']}';
      send = data['send'];
    });
  }

  void putChanges() async {
    String url = '${Endpoints.baseUrl}user/inquiries/${widget.id}/update/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    Map<String, String> data_ = {
      "type": type.toString(),
      "name": name,
      "technical_detail": description,
      // "expiry": DateTime(now.year, now.month, now.day + date).toString(),
      "amount": amount == "" ? "0" : amount,
      "unit": unit == "" ? "0" : unit,
    };
    var response = await http.put(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "type": type.toString(),
        "name": name,
        "technical_detail": description,
        // "expiry": DateTime(now.year, now.month, now.day + date).toString(),
        "amount": amount == "" ? "0" : amount,
        "unit": unit == "" ? "0" : unit,
      },
    );
    if (response.statusCode == 200) {
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('استعلام با موفقیت ویرایش شد'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _unitController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.isEdit) {
      getLastData();
    }
    super.initState();
  }

  void sendImageAndChat(id, image) {
    void sendData(String send) async {
      String? token = await SecureStorage.readSecureStorage(Keys.token);

      String url = '${Endpoints.baseUrl}user/inquiries/$id/send/';
      String imageUrl = '${Endpoints.baseUrl}user/inquiries/$id/image/';
      final request = http.MultipartRequest('POST', Uri.parse(imageUrl));

      Map<String, dynamic> data = {'send': send};

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (image != null && image != '') {
        request.files.add(
          await http.MultipartFile.fromPath('images', image.path),
        );
      }

      var response2 = await request.send();

      if (response.statusCode == 200 || response2.statusCode == 200) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('استعلام جدید با موفقیت ایجاد شد'),
          ),
        );
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colora.scaffold,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.all(Dimensions.width * 0.05),
              decoration: BoxDecoration(
                color: Colora.scaffold,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ارسال استعلام',
                    style: TextStyle(
                      color: Colora.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: Colora.primaryColor, height: 5),
                  const SizedBox(height: 10),
                  const Text(
                    'کاربر گرامی از چه طریقی قصد ارسال استعلام را دارید ؟',
                    style: TextStyle(color: Colora.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colora.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          sendData('sms');
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('ارسال پیامک'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colora.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          sendData('chat');
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('ارسال توسط آسود'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Navigator.pop(context);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         backgroundColor: Colors.green,
    //         content: Text('استعلام جدید با موفقیت ایجاد شد'),
    //       ),
    //     );
  }

  void sendInquiry(
    String type,
    String name,
    String description,
    String send,
    // File? image,
    String amount,
    String unit,
    int date,
  ) async {
    String url = '${Endpoints.baseUrl}user/inquiries/create/';

    String? token = await SecureStorage.readSecureStorage(Keys.token);
    final request = http.MultipartRequest('POST', Uri.parse(url));

    String type_ = type == 'good' ? 'محصول' : 'خدمت';

    if (name == '') {
      showSnackBar(context, 'لطفاً نام $type_ را وارد کنید');
    } else if (description == '') {
      showSnackBar(context, 'لطفاً توضیحات $type_ را وارد کنید');
    } else if (send == 'نحوه استعلام') {
      showSnackBar(context, 'لطفاً نحوه استعلام را وارد کنید');
    } else {
      DateTime now = DateTime.now();

      Map<String, String> data_ = {
        "type": type.toString(),
        "name": name,
        "technical_detail": description,
        "expiry": DateTime(now.year, now.month, now.day + date).toString(),
        "amount": amount == "" ? "0" : amount,
        "unit": unit == "" ? "0" : unit,
      };

      var data = json.encode(data_);

      // request.headers.addAll({
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      //   'Content-Type': 'application/json',
      // });

      request.fields.addAll(data_);

      // if (image != null) {
      //   request.files.add(
      //     await http.MultipartFile.fromPath('image', image.path),
      //   );
      // }

      // var response = await request.send();

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 201) {
        sendImageAndChat(jsonDecode(response.body)['data']['id'], image);
      }
    }

    //   void sendReply(parrentId, message) async {
    //   String url = 'http://asoud.ir/api/v1/user/comment/create/';

    //   String? token = await SecureStorage.readSecureStorage(Keys.token);

    //   Map<String, String> data_ = {
    //     "content_type": "product",
    //     "object_id": widget.productDetails.id.toString(),
    //     "parent_id": parrentId.toString(),
    //     "comment": message.toString(),
    //   };

    //   var data = json.encode(data_);

    //   if (response.statusCode == 201) {
    //     setState(() {
    //       getProductByID(widget.productDetails.id.toString());
    //       getCommentsByID(widget.productDetails.id.toString());
    //       getDiscountByID(widget.productDetails.id.toString());
    //       nameController.clear();
    //       emailController.clear();
    //       messageController.clear();

    //       replyId = -1;
    //     });
    //   } else {}
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.isEdit ? 'ویرایش استعلام' : 'افزودن استعلام جدید',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              width: Dimensions.width * 0.9,
              margin: const EdgeInsets.all(20),
              child: Column(children: [_buildRadioButtons(), _buildForm()]),
            ),
          ),
        ),
      ),
      extendBody: true,
      // bottomNavigationBar: SimpleBotNavBar(),
    );
  }

  Widget _buildRadioButtons() {
    return IntrinsicWidth(
      child: Container(
        height: 80,
        // width: 400,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colora.primaryColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              radioButton(
                title: 'محصول',
                groupValue: 'good',
                value: type,
                onChanged: (value) {
                  setState(() {
                    type = 'good';
                  });
                },
              ),
              radioButton(
                title: 'خدمت',
                groupValue: 'service',
                value: type,
                onChanged: (value) {
                  setState(() {
                    type = 'service';
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: Dimensions.width * 0.9,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colora.primaryColor,
      ),
      child: Column(
        children: [
          CustomTextField(
            controller: _titleController,

            text: widget.isEdit ? name : "نام کالای مورد نیاز",
            onChanged: (p0) => name = p0,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: _descriptionController,
            text: widget.isEdit ? technicalDetails : "توضیحات",
            maxLine: 5,
            onChanged: (p1) => description = p1,
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colora.backgroundSwitch,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    text: widget.isEdit ? amount : "مقدار",
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9۰-۹]')),
                    ],
                    onChanged: (p0) {
                      amount = p0;
                    },
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: _unitController,
                    text: widget.isEdit ? unit : "واحد",
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9۰-۹]')),
                    ],
                    onChanged: (p0) {
                      unit = p0;
                    },
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: _dateController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9۰-۹]')),
                    ],
                    text: 'به مدت',
                    onChanged: (p0) {
                      date = int.parse(p0);
                      setState(() {
                        _dateController.text = '$p0 روز';
                        if (p0 == '') {
                          _dateController.clear();
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text("تصویر کالا"),
                const Text(
                  "عکس مورد نظر خود را از این بخش میتوانید بارگزاری نمایید:",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 50,
                      child: CustomButton(
                        onPress: () async {
                          var maxFileSizeInBytes = 5 * 1048576;

                          final ImagePicker picker = ImagePicker();
                          XFile? logoImage = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          setState(() {
                            imageFile = logoImage!;
                          });

                          var imagePath = await logoImage!.readAsBytes();
                          setState(() {
                            image = imageFile;
                          });
                          var fileSize = imagePath.length;
                          if (context.mounted) {
                            if (fileSize <= maxFileSizeInBytes) {
                              // context.read<AddProductBloc>().add(
                              //   UpdateCategoryImageEvent(
                              //     selectedCategoryImage: logoImage.path,
                              //     selectedCategoryImageFile: logoImage,
                              //   ),
                              // );
                            } else {
                              showSnackBar(
                                context,
                                "حجم عکس بیش از ۵ مگابایت است",
                              );
                            }
                          }
                        },
                        text: imageFile == null ? "افزودن" : 'ویرایش',
                      ),
                    ),
                    widget.isEdit
                        ? lastImage == ''
                            ? Container()
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                lastImage,
                                height: Dimensions.height * 0.1,
                                width: Dimensions.height * 0.1,
                                fit: BoxFit.fill,
                              ),
                            )
                        : imageFile != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.file(
                            File(imageFile.path),
                            height: Dimensions.height * 0.1,
                            width: Dimensions.height * 0.1,
                            fit: BoxFit.fill,
                          ),
                        )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 150,
                margin: const EdgeInsets.all(10.0),
                child: CustomButton(
                  onPress: () {
                    if (widget.isEdit) {
                      putChanges();
                    } else {
                      sendInquiry(
                        type,
                        name,
                        description,
                        'sms',
                        // File(imageFile.path),
                        amount,
                        unit,
                        date,
                      );
                    }
                  },
                  text: "ثبت",
                  color: Colors.white,
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
