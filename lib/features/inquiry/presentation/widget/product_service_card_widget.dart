import 'package:flutter/material.dart';

class ProductServiceCard extends StatelessWidget {
  const ProductServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepPurple,
        ),
        height: 150,
        child: const Center(
          child: Text('Item'),
        ),
      ),
    );
  }
}
