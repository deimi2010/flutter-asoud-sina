import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationDialog {
  static void showLocationSelector({
    required String title,
    required BuildContext context,
    required List<dynamic> items,
    required String Function(dynamic) getName,
    required String? Function(dynamic) getId,
    required void Function(dynamic) onSelect,
    VoidCallback? onLoad,
  }) {
    if (onLoad != null) onLoad();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colora.scaffold,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.width * 0.03,
          ),
          backgroundColor: Colora.primaryColor,
          content: BlocBuilder<CreateWorkSpaceBloc, CreateWorkSpaceState>(
            builder: (context, state) {
              if (state.status == CWSStatus.success) {
                return Container(
                  width: Dimensions.width * 0.7,
                  height: Dimensions.height * 0.5,
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height * 0.01,
                    horizontal: Dimensions.width * 0.0,
                  ),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: Dimensions.height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: Colora.scaffold,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            onSelect(item);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            getName(item),
                            style: const TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state.status == CWSStatus.loading) {
                return SizedBox(
                  width: Dimensions.width * 0.7,
                  height: Dimensions.height * 0.5,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colora.scaffold),
                  ),
                );
              } else {
                return SizedBox(
                  width: Dimensions.width * 0.7,
                  height: Dimensions.height * 0.5,
                  child: const Center(
                    child: Text(
                      'خطا در برقراری اطلاعات',
                      style: TextStyle(color: Colora.scaffold),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
