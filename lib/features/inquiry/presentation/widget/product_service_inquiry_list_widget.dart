import 'package:flutter/material.dart';

import 'package:asood/features/inquiry/presentation/widget/product_service_card_widget.dart';

class ProductServiceInquiryList extends StatelessWidget {
  const ProductServiceInquiryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return const Row(
            children: <Widget>[
              ProductServiceCard(),
              SizedBox(width: 8),
              ProductServiceCard(),
            ],
          );
        },
      ),
    );
  }
}
