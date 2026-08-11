import 'dart:io';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class ProductPicSection extends StatelessWidget {
  const ProductPicSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductBloc, AddProductState>(
      builder: (context, state) {
        return Container(
          width: Dimensions.width,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.06),
          decoration: BoxDecoration(
            color: Colora.scaffold,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(
                  vertical: Dimensions.height * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تصویر محصول : ',
                      style: TextStyle(
                        color: Colora.primaryColor,
                        fontSize: Dimensions.width * 0.035,
                      ),
                    ),
                    if (state.selectedCategoryImageFile != null)
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.file(
                          File(state.selectedCategoryImage!.first),
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'انتخاب عکس برای محصول باعث جذب مشتری می‌شود.',
                  style: TextStyle(
                    color: Colora.primaryColor,
                    fontSize: Dimensions.width * 0.03,
                  ),
                ),
              ),

              //add image
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: Dimensions.width * 0.35,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: Dimensions.height * 0.01,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height * 0.01,
                        horizontal: Dimensions.width * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Colora.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: InkWell(
                        onTap: () async {
                          var maxFileSizeInBytes = 5 * 1048576;

                          final ImagePicker picker = ImagePicker();
                          XFile? logoImage = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          var imagePath = await logoImage!.readAsBytes();
                          var fileSize = imagePath.length;
                          if (context.mounted) {
                            if (fileSize <= maxFileSizeInBytes) {
                              context.read<AddProductBloc>().add(
                                UpdateCategoryImageEvent(
                                  selectedCategoryImage: logoImage.path,
                                  selectedCategoryImageFile: logoImage,
                                ),
                              );
                            } else {
                              showSnackBar(
                                context,
                                "حجم عکس بیش از ۵ مگابایت است",
                              );
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Iconsax.gallery_add5,
                              // Icons.add_photo_alternate_rounded,
                              color: Colora.scaffold,
                              size: Dimensions.width * 0.06,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                'افزودن عکس',
                                style: TextStyle(
                                  fontSize: Dimensions.width * 0.033,
                                  color: Colora.scaffold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //images
              Container(
                width: Dimensions.width,
                height:
                    state.productImages.isEmpty ? 0 : Dimensions.height * 0.1,
                margin: EdgeInsets.symmetric(
                  vertical: Dimensions.height * 0.01,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.productImages.length,
                  itemBuilder:
                      (context, index) => Stack(
                        children: [
                          Container(
                            width: Dimensions.width * 0.2,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width * 0.02,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colora.primaryColor),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colora.primaryColor,
                                border: Border.all(color: Colora.primaryColor),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.delete_rounded,
                                color: Colors.redAccent,
                                size: Dimensions.width * 0.045,
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
