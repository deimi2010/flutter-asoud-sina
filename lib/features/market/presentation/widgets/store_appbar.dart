import 'dart:io';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/widgets/appbar/menu_dialog.dart';
import 'package:asood/core/widgets/appbar/profile_menu_widget.dart';
import 'package:asood/features/vendor/presentation/bloc/vendor/vendor_bloc.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class StoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StoreAppBar({
    super.key,
    required this.context,
    this.appbarTools,
    required this.title,
    required this.description,
    this.image,
    this.isAdmin = false,
  });
  final String title;
  final String description;
  final String? image;

  final BuildContext context;
  final Widget? appbarTools;
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 210,
      title: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colora.primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Asood Store',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(title),
                Text(description, style: ATextStyle.light12),
                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      actions: [
        // Profile button
        Container(
          margin: const EdgeInsets.only(bottom: 100),
          child: IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              showProfileDialog(context);
            },
          ),
        ),
      ],
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const MenuDialog(),
                );
              },
            ),
          );
        },
      ),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        child: Stack(
          //fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/home_app_bar.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                color: const Color.fromARGB(255, 0, 4, 253).withOpacity(0.5),
              ),
              margin: const EdgeInsets.only(bottom: 20),
            ),
            appbarTools ?? Container(),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(210);
}

class StoreAppbar2 extends StatefulWidget {
  final String id;
  final String? title;
  final String? description;
  final String? logoImage;
  final String? backImage;
  final Color? mainColor;
  final Color? fontColor;
  final String? fontFamily;
  final bool isAdmin;

  const StoreAppbar2({
    super.key,
    required this.id,
    this.title,
    this.description,
    this.logoImage,
    this.backImage,
    this.mainColor = Colora.primaryColor,
    this.fontColor = Colors.white,
    this.fontFamily,
    this.isAdmin = false,
  });

  @override
  State<StoreAppbar2> createState() => _StoreAppbar2State();
}

class _StoreAppbar2State extends State<StoreAppbar2> {
  String initLogoImage = '';
  String editLogoImage = '';
  XFile? logoImage;

  String initBackImage = '';
  String editBackImage = '';
  XFile? backImage;

  late VendorBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc = BlocProvider.of<VendorBloc>(context);

    initLogoImage = widget.logoImage!;
    editLogoImage = widget.logoImage!;
    initBackImage = widget.backImage!;
    editBackImage = widget.backImage!;
  }

  void changeLogo(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: SizedBox(
                  height: Dimensions.height * 0.27,
                  child: BlocConsumer<VendorBloc, VendorState>(
                    listener: (context, state) {
                      if (state.status == CWSStatus.failure) {
                        showSnackBar(context, "مشکلی پیش آمده مجددا تلاش کنید");
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          //title
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'عکس لوگو',
                              style: TextStyle(
                                color: Colora.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.width * 0.05,
                              ),
                            ),
                          ),

                          const Divider(color: Colora.primaryColor),

                          //description
                          Text(
                            'جهت انتخاب عکس خود بر روی افزودن عکس کلیک کنید.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.width * 0.035,
                            ),
                          ),

                          //buttons and preview
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //add
                              InkWell(
                                onTap: () async {
                                  var maxFileSizeInBytes = 5 * 1048576;

                                  final ImagePicker picker = ImagePicker();
                                  logoImage = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );

                                  var imagePath =
                                      await logoImage!.readAsBytes();
                                  var fileSize = imagePath.length;

                                  if (fileSize <= maxFileSizeInBytes) {
                                    setState(() {
                                      editLogoImage = logoImage!.path;
                                    });
                                  } else {
                                    showSnackBar(
                                      context,
                                      "حجم عکس بیش از ۵ مگابایت است",
                                    );
                                  }
                                },
                                child: Container(
                                  width: Dimensions.width * 0.2,
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colora.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'افزودن عکس',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: Dimensions.width * 0.033,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // delete
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    editLogoImage = '';
                                  });
                                },
                                child: Container(
                                  width: Dimensions.width * 0.2,
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colora.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'حذف عکس',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: Dimensions.width * 0.033,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //preview
                              SizedBox(
                                width: Dimensions.width * 0.2,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colora.backgroundSwitch,
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child:
                                          editLogoImage == ''
                                              ? Image.asset(
                                                'assets/images/logo.png',
                                                fit: BoxFit.cover,
                                              )
                                              : editLogoImage.contains('http')
                                              ? CachedNetworkImage(
                                                imageUrl: editLogoImage,
                                                imageBuilder: (
                                                  context,
                                                  imageProvider,
                                                ) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                placeholder:
                                                    (
                                                      context,
                                                      url,
                                                    ) => Shimmer.fromColors(
                                                      baseColor: Colors.grey
                                                          .withOpacity(0.2),
                                                      highlightColor: Colors
                                                          .black
                                                          .withOpacity(0.2),
                                                      direction:
                                                          ShimmerDirection.rtl,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              )
                                              : Image.file(
                                                File(editLogoImage),
                                                fit: BoxFit.cover,
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //back and save
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //save
                              Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    state.status == CWSStatus.loading
                                        ? Container(
                                          width: Dimensions.width * 0.3,
                                          height: Dimensions.height * 0.042,
                                          padding: EdgeInsets.symmetric(
                                            vertical: Dimensions.height * 0.01,
                                          ),
                                          margin: EdgeInsets.only(
                                            top: Dimensions.height * 0.02,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colora.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: const Center(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: CircularProgressIndicator(
                                                color: Colora.scaffold_,
                                              ),
                                            ),
                                          ),
                                        )
                                        : InkWell(
                                          onTap: () {
                                            if (logoImage != null) {
                                              bloc.add(
                                                AddLogoEvent(
                                                  id: widget.id,
                                                  logoImage: logoImage!,
                                                ),
                                              );
                                              Navigator.pop(context);
                                              initLogoImage = editLogoImage;
                                            } else if (editLogoImage == '') {
                                              bloc.add(
                                                DeleteLogoEvent(id: widget.id),
                                              );
                                              Navigator.pop(context);
                                              initLogoImage = editLogoImage;
                                            } else {
                                              showSnackBar(
                                                context,
                                                "لطفا عکس خود را انتخاب یا حذف کنید",
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.width * 0.3,
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.height * 0.01,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: Dimensions.height * 0.02,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colora.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'ذخیره',
                                                  style: TextStyle(
                                                    color: Colora.scaffold,
                                                    fontSize:
                                                        Dimensions.width *
                                                        0.033,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                              ),

                              //back
                              InkWell(
                                onTap: () {
                                  editLogoImage = widget.logoImage!;
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: Dimensions.width * 0.3,
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height * 0.01,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: Dimensions.height * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colora.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'بازگشت',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: Dimensions.width * 0.033,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
    );
  }

  void changeBack(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: BlocConsumer<VendorBloc, VendorState>(
                  listener: (context, state) {
                    if (state.status == CWSStatus.success) {
                    } else if (state.status == CWSStatus.failure) {
                      showSnackBar(context, "مشکلی پیش آمده مجددا تلاش کنید");
                    }
                  },
                  builder:
                      (context, state) => SizedBox(
                        height: Dimensions.height * 0.25,
                        child: Column(
                          children: [
                            //title
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'عکس پس زمینه',
                                style: TextStyle(
                                  color: Colora.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.width * 0.05,
                                ),
                              ),
                            ),

                            const Divider(color: Colora.primaryColor),

                            //description
                            Text(
                              'جهت انتخاب عکس خود بر روی افزودن عکس کلیک کنید.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colora.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: Dimensions.width * 0.035,
                              ),
                            ),

                            //buttons and preview
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // add
                                InkWell(
                                  onTap: () async {
                                    var maxFileSizeInBytes = 5 * 1048576;

                                    final ImagePicker picker = ImagePicker();
                                    backImage = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    var imagePath =
                                        await backImage!.readAsBytes();
                                    var fileSize = imagePath.length;

                                    if (fileSize <= maxFileSizeInBytes) {
                                      setState(() {
                                        editBackImage = backImage!.path;
                                      });
                                    } else {
                                      showSnackBar(
                                        context,
                                        "حجم عکس بیش از ۵ مگابایت است",
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.width * 0.2,
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colora.primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'افزودن عکس',
                                          style: TextStyle(
                                            color: Colora.scaffold,
                                            fontSize: Dimensions.width * 0.033,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // delete
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      editBackImage = '';
                                    });
                                  },
                                  child: Container(
                                    width: Dimensions.width * 0.2,
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colora.primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'حذف عکس',
                                          style: TextStyle(
                                            color: Colora.scaffold,
                                            fontSize: Dimensions.width * 0.033,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //preview
                                SizedBox(
                                  width: Dimensions.width * 0.2,
                                  child: AspectRatio(
                                    aspectRatio: 4 / 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colora.backgroundSwitch,
                                          width: 3,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child:
                                            editBackImage == ''
                                                ? Image.asset(
                                                  'assets/images/home_app_bar.png',
                                                  fit: BoxFit.cover,
                                                )
                                                : editBackImage.contains('http')
                                                ? CachedNetworkImage(
                                                  imageUrl: editBackImage,
                                                  imageBuilder: (
                                                    context,
                                                    imageProvider,
                                                  ) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  placeholder:
                                                      (
                                                        context,
                                                        url,
                                                      ) => Shimmer.fromColors(
                                                        baseColor: Colors.grey
                                                            .withOpacity(0.2),
                                                        highlightColor: Colors
                                                            .black
                                                            .withOpacity(0.2),
                                                        direction:
                                                            ShimmerDirection
                                                                .rtl,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                            Icons.error,
                                                          ),
                                                )
                                                : Image.file(
                                                  File(editBackImage),
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //save and back
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //save
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      state.status == CWSStatus.loading
                                          ? Container(
                                            width: Dimensions.width * 0.3,
                                            height: Dimensions.height * 0.042,
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.height * 0.01,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: Dimensions.height * 0.02,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colora.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Center(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Colora.scaffold_,
                                                    ),
                                              ),
                                            ),
                                          )
                                          : InkWell(
                                            onTap: () {
                                              if (backImage != null) {
                                                bloc.add(
                                                  AddBackgroundEvent(
                                                    id: widget.id,
                                                    backgroundImage: backImage!,
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                initBackImage = editBackImage;
                                              } else if (editBackImage == '') {
                                                bloc.add(
                                                  DeleteBackgroundEvent(
                                                    id: widget.id,
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                initBackImage = editBackImage;
                                              } else {
                                                showSnackBar(
                                                  context,
                                                  "لطفا عکس خود را انتخاب یا حذف کنید",
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: Dimensions.width * 0.3,
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.height * 0.01,
                                              ),
                                              margin: EdgeInsets.only(
                                                top: Dimensions.height * 0.02,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colora.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    'ذخیره',
                                                    style: TextStyle(
                                                      color: Colora.scaffold,
                                                      fontSize:
                                                          Dimensions.width *
                                                          0.033,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                ),

                                //back
                                InkWell(
                                  onTap: () {
                                    editBackImage = widget.backImage!;
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: Dimensions.width * 0.3,
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height * 0.01,
                                    ),
                                    margin: EdgeInsets.only(
                                      top: Dimensions.height * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colora.primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'بازگشت',
                                          style: TextStyle(
                                            color: Colora.scaffold,
                                            fontSize: Dimensions.width * 0.033,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                ),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      width: Dimensions.width,
      height: Dimensions.height * 0.25,
      child: Container(
        width: Dimensions.width,
        height: Dimensions.height * 0.25,
        padding: EdgeInsets.only(bottom: Dimensions.height * 0.015),
        decoration: BoxDecoration(
          color: widget.mainColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          child: Stack(
            children: [
              // image
              SizedBox(
                width: Dimensions.width,
                height: Dimensions.height * 0.25,
                child:
                    initBackImage == ''
                        ? Image.asset(
                          'assets/images/home_app_bar.png',
                          fit: BoxFit.cover,
                        )
                        : initBackImage.contains('http')
                        ? CachedNetworkImage(
                          imageUrl: initBackImage,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder:
                              (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.2),
                                highlightColor: Colors.black.withOpacity(0.2),
                                direction: ShimmerDirection.rtl,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        )
                        : Image.file(File(initBackImage), fit: BoxFit.cover),
              ),

              //image cover
              if (widget.isAdmin)
                InkWell(
                  onTap: () {
                    changeBack(context);
                  },
                  child: Container(
                    width: Dimensions.width,
                    height: Dimensions.height * 0.25,
                    color: widget.mainColor?.withOpacity(0.6),
                  ),
                ),

              //back
              Positioned(
                top: 20,
                right: 10,
                width: Dimensions.width * 0.1,
                child: SizedBox(
                  width: Dimensions.width * 0.1,
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<WorkspaceBloc>(context).add(LoadStores());
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colora.scaffold,
                      size: Dimensions.width * 0.07,
                    ),
                  ),
                ),
              ),

              //menu button
              widget.id == 'productAppBar'
                  ? Container()
                  : Positioned(
                    top: 20,
                    left: 10,
                    width: Dimensions.width * 0.1,
                    child: InkWell(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colora.scaffold,
                              width: 2,
                            ),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/placeholder.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const MenuDialog(),
                        );
                      },
                    ),
                  ),

              Column(
                children: [
                  //image
                  Container(
                    height: Dimensions.height * 0.1,
                    margin: EdgeInsets.fromLTRB(
                      Dimensions.width * 0.39,
                      Dimensions.height * 0.02,
                      Dimensions.width * 0.39,
                      Dimensions.height * 0.01,
                    ),
                    child: Stack(
                      children: [
                        // image
                        widget.id == 'productAppBar'
                            ? Container()
                            : AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: widget.mainColor!,
                                    width: 3,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:
                                      initLogoImage == ''
                                          ? SvgPicture.asset(
                                            'assets/images/logo_svg.svg',
                                            colorFilter: ColorFilter.mode(
                                              widget.mainColor!,
                                              BlendMode.srcIn,
                                            ),
                                          )
                                          : initLogoImage.contains('http')
                                          ? CachedNetworkImage(
                                            imageUrl: initLogoImage,
                                            imageBuilder: (
                                              context,
                                              imageProvider,
                                            ) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                            placeholder:
                                                (
                                                  context,
                                                  url,
                                                ) => Shimmer.fromColors(
                                                  baseColor: Colors.grey
                                                      .withOpacity(0.2),
                                                  highlightColor: Colors.black
                                                      .withOpacity(0.2),
                                                  direction:
                                                      ShimmerDirection.rtl,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )
                                          : Image.file(
                                            File(initLogoImage),
                                            fit: BoxFit.cover,
                                          ),
                                ),
                              ),
                            ),

                        // edit
                        if (widget.isAdmin)
                          Positioned(
                            top: Dimensions.height * 0.07,
                            child: InkWell(
                              onTap: () {
                                changeLogo(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: widget.mainColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: widget.mainColor!,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Iconsax.edit5,
                                  // Icons.edit_rounded,
                                  color: widget.fontColor!,
                                  size: Dimensions.width * 0.05,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  //title
                  Text(
                    widget.title!,
                    style: TextStyle(
                      color: widget.fontColor,
                      fontSize: Dimensions.width * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: widget.fontFamily,
                    ),
                  ),

                  SizedBox(height: Dimensions.height * 0.005),

                  //des
                  widget.id == 'productAppBar'
                      ? Container()
                      : Expanded(
                        child: Text(
                          'برند اصل برای همه',
                          style: TextStyle(
                            color: widget.fontColor,
                            fontSize: Dimensions.width * 0.035,
                            fontFamily: widget.fontFamily,
                          ),
                        ),
                      ),
                ],
              ),
              if (widget.isAdmin)
                Positioned(
                  left: 50,
                  bottom: 50,
                  child: InkWell(
                    onTap: () {
                      changeLogo(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.mainColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: widget.mainColor!, width: 2),
                      ),
                      child: Icon(
                        Iconsax.edit5,
                        // Icons.edit_rounded,
                        color: widget.fontColor!,
                        size: Dimensions.width * 0.05,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
