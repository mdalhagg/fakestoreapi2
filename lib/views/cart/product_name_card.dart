import 'package:flutter/material.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class ProductNameCard extends StatelessWidget {
  const ProductNameCard(
      {super.key, required this.cartController, required this.index});

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(cartController.cart?[index].title ?? '',
        style: LightTheme.textStyle(fontSize: 16));
  }
}
