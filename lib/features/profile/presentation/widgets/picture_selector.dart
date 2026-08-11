import 'dart:io';

import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PictureSelector extends StatefulWidget {
  const PictureSelector({super.key});

  @override
  State<PictureSelector> createState() => _PictureSelectorState();
}

class _PictureSelectorState extends State<PictureSelector> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _profileImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colora.scaffold,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.04,
        vertical: Dimensions.height * 0.015,
      ),
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimensions.width * 0.49,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'عکس پروفایل',
                  style: TextStyle(fontSize: 13, color: Colora.primaryColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height * 0.01,
                  ),
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'جهت انتخاب عکس خود بر روی افزودن عکس کلیک کنید',
                      style: TextStyle(
                        fontSize: 8.5,
                        color: Colora.primaryColor,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: _pickImage,
                      child: Container(
                        width: Dimensions.width * 0.24,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              color: Colora.scaffold,
                              size: 15,
                            ),
                            Text(
                              'افزودن عکس',
                              style: TextStyle(
                                color: Colora.scaffold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _profileImage != null ? _removeImage : null,
                      child: Container(
                        width: Dimensions.width * 0.24,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colora.scaffold,
                              size: 15,
                            ),
                            Text(
                              'حذف کردن',
                              style: TextStyle(
                                color: Colora.scaffold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   icon: const Icon(Icons.add_a_photo),
                    //   label: const Text('افزودن'),
                    //   onPressed: _pickImage,
                    // ),
                    // ElevatedButton.icon(
                    //   icon: const Icon(Icons.delete_outline),
                    //   label: const Text('حذف'),
                    //   onPressed: _profileImage != null ? _removeImage : null,
                    // ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            width: Dimensions.width * 0.2,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image:
                        _profileImage != null
                            ? FileImage(_profileImage!) as ImageProvider
                            : const AssetImage('assets/images/placeholder.jpg')
                                as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
