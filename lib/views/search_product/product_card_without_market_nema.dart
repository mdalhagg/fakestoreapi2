import 'package:fakestoreapi/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:fakestoreapi/components/product_card.dart';

class ProductCardWithoutMarketName extends StatelessWidget {
  const ProductCardWithoutMarketName(
      {super.key, required this.controller, required this.index});

  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width < 600
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width / 2.1,
      child: ProductCard(
        index: index,
        data: controller.home?[index],
      ),
    );
  }
}
