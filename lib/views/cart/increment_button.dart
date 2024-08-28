import 'package:flutter/material.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class IncrementButton extends StatelessWidget {
  const IncrementButton(
      {super.key, required this.cartController, required this.index});

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        cartController.isLoading = true;
        await cartController.changeQuantity(context,
            index: index,
            quantity: (cartController.cart?[index].quantity ?? 0) + 1);
        // update widget.data
        cartController.cart?[index].quantity =
            cartController.cart?[index].quantity;

        // setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: LightTheme.main),
        child: Icon(
          Icons.add,
          color: LightTheme.textWhite,
          size: 22,
        ),
      ),
    );
  }
}
