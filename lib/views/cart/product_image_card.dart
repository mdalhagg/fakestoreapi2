import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fakestoreapi/controllers/cart.dart';

class ProductImageCard extends StatelessWidget {
  const ProductImageCard(
      {super.key, required this.cartController, required this.index});

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 80,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
              cartController.cart?[index].image ?? ''),
        ),
      ),
    );
  }
}
