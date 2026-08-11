import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/vendor/presentation/bloc/vendor/vendor_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CMBox extends StatelessWidget {
  const CMBox({
    super.key,
    required this.senderName,
    required this.messageText,
    required this.senderImageUrl,
  });

  final String senderName;
  final String messageText;
  final String senderImageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorBloc, VendorState>(
      builder:
          (context, state) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(senderImageUrl),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      senderName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: state.fontFamily,
                        color: state.fontColor,
                        fontSize: Dimensions.width * 0.035,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: Dimensions.width * .8,
                        minHeight: 100,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: state.secondColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          messageText,
                          style: TextStyle(
                            fontFamily: state.fontFamily,
                            color: state.fontColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
