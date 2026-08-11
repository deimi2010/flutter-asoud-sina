import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/store_card.dart';
import 'package:asood/features/business_card/presentation/screens/business_card.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessList extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const BusinessList({super.key, required this.data});

  @override
  State<BusinessList> createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {
  @override
  Widget build(BuildContext context) {
    print(widget.data.toString());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: DefaultAppBar(title: 'کارت ویزیت ها'),
      body: Stack(
        children: [
          widget.data.isEmpty
              ? Center(
                child: SizedBox(
                  height: Dimensions.width * 0.1,
                  width: Dimensions.width * 0.1,
                  child: CircularProgressIndicator(
                    color: Colora.backgroundDialog,
                  ),
                ),
              )
              : ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return BusinessCard(data: widget.data[index]);
                          },
                        ),
                      );
                    },
                    child: StoreCard(
                      bloc: BlocProvider.of<WorkspaceBloc>(context),
                      index: index,
                      market:
                          BlocProvider.of<WorkspaceBloc>(
                            context,
                          ).state.storesList[index],
                      menuVisibility: false,
                    ),
                  );
                },
                itemCount: widget.data.length,
              ),
        ],
      ),
    );
  }
}
