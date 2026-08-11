import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ItemBoxTitle extends StatelessWidget {
  const ItemBoxTitle({
    required this.title,
    required this.child,
    this.onTap,
    super.key,
  });
  final String title;
  final Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colora.lightBlue,
                ),
                child: Center(child: child),
              ),
              const SizedBox(height: 3),
              Text(title, style: ATextStyle.blueBold11),
            ],
          ),
        ),
      ),
    );
  }
}
