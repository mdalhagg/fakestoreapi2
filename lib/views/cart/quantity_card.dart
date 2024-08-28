import 'package:flutter/material.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class QuantityCard extends StatelessWidget {
  const QuantityCard(
      {super.key, required this.cartController, required this.index});

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Text('${cartController.cart?[index].quantity ?? 0}',
          style: LightTheme.textStyle(fontSize: 20)),
    );
  }
}
