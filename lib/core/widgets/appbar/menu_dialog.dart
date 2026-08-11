import 'package:asood/core/router/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MenuDialog extends StatelessWidget {
  const MenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("منو"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem(
              context,
              title: "خانه",
              onTap: () => context.push(AppRoutes.vendorHome, extra: "home"),
            ),
            _buildMenuItem(
              context,
              title: "لیست صفحات",
              onTap: () => context.push(AppRoutes.screenLists),
            ),
            _buildMenuItem(
              context,
              title: "داشبورد فروشنده",
              onTap: () => context.push(AppRoutes.vendorDashboard),
            ),
            _buildMenuItem(
              context,
              title: "داشبورد خریدار",
              onTap: () => context.push(AppRoutes.customerDashboard),
            ),
            _buildMenuItem(
              context,
              title: "تنظیمات",
              onTap: () => context.push(AppRoutes.settings),
            ),
            const MenuItem(title: "درباره ما"), // بدون action
            _buildMenuItem(
              context,
              title: "خروج",
              onTap: () => SystemNavigator.pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return MenuItem(title: title, onTap: onTap);
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const MenuItem({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title), onTap: onTap);
  }
}
