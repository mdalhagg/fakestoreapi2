
import 'package:flutter/material.dart';
import 'package:fakestoreapi/components/app_component.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/router.dart';
import 'package:fakestoreapi/views/cart/cart_item.dart';
import 'package:fakestoreapi/views/cart/checkout_button.dart';
import 'package:fakestoreapi/views/cart/delete_item.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = CartController();

  double total = 0;
  double discount = 0;
  double totalPrice = 0;
  getPrice() async {
    total = 0;
    discount = 0;
    totalPrice = 0;
    settingsController.cart?.forEach((e) {
      total += ((e.price ?? 0) * (e.quantity ?? 0));
    });
    totalPrice = (total - discount);
  }

  @override
  void initState() {
    // log(jsonEncode(cartController.cart));
    super.initState();
    if (mounted) {
      cartController.addListener(() {
        cartController.cart;
        if (mounted) setState(() {});
      });
      cartController.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getPrice();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'السله',
          style: LightTheme.textStyle(color: LightTheme.main),
        ),
        shadowColor: Colors.transparent,
      ),
      body: PageView(
        children: [
          cartController.isLoading == true
              ? LoadingCard()
              : cartController.cart?.isEmpty == true ||
                      cartController.cart == null
                  ? NoDataCartCard()
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Wrap(
                                  children: List.generate(
                                    cartController.cart?.length ?? 0,
                                    (index) => SizedBox(
                                      width: MediaQuery.of(context).size.width <
                                              600
                                          ? MediaQuery.of(context).size.width
                                          : MediaQuery.of(context).size.width /
                                              2.1,
                                      child: Stack(
                                        children: [
                                          CartItemCard(
                                              cartController: cartController,
                                              index: index),
                                          DeleteItemCard(
                                            cartController: cartController,
                                            index: index,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        ],
      ),
      bottomNavigationBar: CheckoutButton(
          totalPrice: totalPrice,
          cartController: cartController,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
