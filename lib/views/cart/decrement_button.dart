import 'package:flutter/material.dart';
import 'package:fakestoreapi/components/snackbar.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class DecrementButton extends StatelessWidget {
  const DecrementButton(
      {super.key, required this.cartController, required this.index});

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // setState(() {});
        if (cartController.cart?[index].quantity == 1) {
          errorSnackbar(context, message: 'لقد وصلت للحد الاقصى');
        } else {
          await cartController.changeQuantity(context,
              index: index,
              quantity: (cartController.cart?[index].quantity ?? 0) - 1);
          cartController.cart?[index].quantity =
              cartController.cart?[index].quantity;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: LightTheme.textGray2),
        child: Icon(
          Icons.remove,
          color: LightTheme.main,
          size: 22,
        ),
      ),
    );
  }
}
