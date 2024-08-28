import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fakestoreapi/components/snackbar.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    required this.totalPrice,
    required this.cartController,
  });

  final double totalPrice;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            LightTheme.background.withOpacity(0.9),
            LightTheme.background.withOpacity(0.5).withAlpha(100),
            LightTheme.main.withOpacity(0.1).withAlpha(90),
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightTheme.textBlack.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'المجموع:',
                  //       style: LightTheme.textStyle(
                  //           fontSize: 16, color: LightTheme.textBlack),
                  //     ),
                  //     Text(
                  //       '${total.toString()} ر.ي',
                  //       style: LightTheme.textStyle(
                  //           fontSize: 16, color: LightTheme.main),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'الخصم:',
                  //       style: LightTheme.textStyle(
                  //           fontSize: 16, color: LightTheme.textBlack),
                  //     ),
                  //     Text(
                  //       '${discount.toString()} ر.ي',
                  //       style: LightTheme.textStyle(
                  //           fontSize: 16, color: LightTheme.main),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'سعر التوصيل:',
                  //       style: LightTheme.textStyle(
                  //           fontSize: 16, color: LightTheme.textBlack),
                  //     ),
                  //     Text(
                  //       '${cartController.deliveryPrice.toString()} ر.ي',
                  //       style: LightTheme.textStyle(
                  //           fontSize: 16, color: LightTheme.main),
                  //     )
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'الاجمالي الكلي:',
                        style: LightTheme.textStyle(
                            fontSize: 16, color: LightTheme.textBlack),
                      ),
                      Text(
                        '${totalPrice}',
                        style: LightTheme.textStyle(
                            fontSize: 16, color: LightTheme.main),
                      )
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (cartController.cart?.isNotEmpty ?? false) {
                    context.push('/checkout');
                  } else {
                    errorSnackbar(
                      context,
                      message:
                          'السلة فارغة الرجاء متابعه التسوق و اضافه منتجات لسلتك',
                    );
                  }
                },
                child: Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: LightTheme.main,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'تأكيد الطلب',
                      style: LightTheme.textStyle(
                          fontSize: 16, color: LightTheme.textWhite),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
