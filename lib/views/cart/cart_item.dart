import 'package:flutter/material.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/views/cart/decrement_button.dart';
import 'package:fakestoreapi/views/cart/increment_button.dart';
import 'package:fakestoreapi/views/cart/price_card.dart';
import 'package:fakestoreapi/views/cart/product_image_card.dart';
import 'package:fakestoreapi/views/cart/product_name_card.dart';
import 'package:fakestoreapi/views/cart/quantity_card.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard(
      {super.key, required this.cartController, required this.index});

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 8, bottom: 8),
      height: 110,
      decoration: BoxDecoration(
          color: LightTheme.background,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: LightTheme.textBlack.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProductImageCard(cartController: cartController, index: index),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductNameCard(
                        cartController: cartController, index: index),
                    PriceCard(cartController: cartController, index: index),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IncrementButton(cartController: cartController, index: index),
              QuantityCard(cartController: cartController, index: index),
              DecrementButton(cartController: cartController, index: index)
            ],
          )
        ],
      ),
    );
  }
}
