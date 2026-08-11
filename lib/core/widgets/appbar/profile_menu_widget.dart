import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/router/app_routers.dart';

class ProfileMenuDialog extends StatelessWidget {
  const ProfileMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      alignment: Alignment.topLeft,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(
            context,
            label: 'پروفایل',
            onTap: () => context.push(AppRoutes.vendorProfile),
          ),
          _buildMenuItem(
            context,
            label: 'تماس با ما',
            onTap: () {
              // TODO: Add contact logic
            },
          ),
          _buildMenuItem(
            context,
            label: 'خروج از حساب کاربری',
            onTap: () {
              SecureStorage.deleteSecureStorage(Keys.token);
              context.go(AppRoutes.login);
            },
          ),
          _buildMenuItem(
            context,
            label: 'خروج از برنامه',
            onTap: () {
              // TODO: Handle app exit
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Dimensions.height * 0.05,
        margin: EdgeInsets.symmetric(vertical: Dimensions.height * 0.01),
        decoration: BoxDecoration(
          color: Colora.primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colora.scaffold,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.width * 0.035,
            ),
          ),
        ),
      ),
    );
  }
}

void showProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const ProfileMenuDialog(),
  );
}
