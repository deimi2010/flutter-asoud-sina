import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/create_workspace/data/model/market_contact.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/create_workspace/presentation/widgets/socialmedia_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialmediaListbuilder extends StatelessWidget {
  SocialmediaListbuilder({super.key});
  final Map<String, String> platforms = {
    'telegram': 'تلگرام',
    'rubika': 'روبیکا',
    'eitaa': 'ایتا',
    'soroush': 'سروش',
    'bale': 'بله',
    'igap': 'ایگپ',
    'whatsapp': 'واتساپ',
    'instagram': 'اینستاگرام',
  };
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateWorkSpaceBloc, CreateWorkSpaceState>(
      builder: (context, state) {
        final items =
            state.messengerIds.toJson(); // تبدیل به Map<String, String>

        if (items.isEmpty ||
            items.values.every((e) => e == null || e!.isEmpty)) {
          return Text(
            "هیچ شبکه اجتماعی اضافه نشده",
            style: TextStyle(color: Colors.white),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final key = items.keys.elementAt(index);
              final value = items[key] ?? "";

              if (value.isEmpty) {
                return SizedBox();
              }

              return Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.khorisontal,
                ),
                decoration: BoxDecoration(
                  color: Colora.scaffold,
                  borderRadius: BorderRadius.circular(Dimensions.twenty),
                ),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${platforms[key]}: $value",
                      style: TextStyle(color: Colora.primaryColor),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colora.primaryColor),
                          onPressed: () {
                            showSocialSelectionDialog(
                              context,
                              defaultKey: key,
                              defaultValue: value,
                              onSubmit: (newKey, newValue) {
                                final updated = state.messengerIds
                                    .copyWithByKey(newKey, newValue);
                                context.read<CreateWorkSpaceBloc>().add(
                                  UpdateMessengerIds(updated),
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colora.primaryColor),
                          onPressed: () {
                            final updated = state.messengerIds.copyWithByKey(
                              key,
                              "",
                            );
                            context.read<CreateWorkSpaceBloc>().add(
                              UpdateMessengerIds(updated),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
