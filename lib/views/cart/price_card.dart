
import 'package:flutter/material.dart';
import 'package:fakestoreapi/controllers/cart.dart';

class PriceCard extends StatelessWidget {
  const PriceCard(
      {super.key, required this.cartController, required this.index});

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("السعر: ",
            style: TextStyle(
              fontSize: 14,
            )),
        Text.rich(
          // textDirection: TextDirection.ltr,
          TextSpan(children: [
            TextSpan(
                text: "${cartController.cart?[index]?.price ?? 0}",
                style: TextStyle(
                  fontSize: 14,
                  decorationColor: Colors.red,
                )),
          ]),
        ),
      ],
    );
  }
}
