import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colora.lightBlue, content: Text(message)),
    );
