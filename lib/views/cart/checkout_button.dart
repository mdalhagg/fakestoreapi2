import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fakestoreapi2/components/snackbar.dart';
import 'package:fakestoreapi2/controllers/cart.dart';
import 'package:fakestoreapi2/theme/light_theme.dart';

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({
    super.key,
    required this.totalPrice,
    required this.cartController,
  });

  final double totalPrice;
  final CartController cartController;

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: LightTheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightTheme.textBlack.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'الاسم كامل:',
                        style: LightTheme.textStyle(
                            fontSize: 16, color: LightTheme.textBlack),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: widget.cartController.nameController,
                          decoration: const InputDecoration(
                            hintText: 'ادخل الاسم كامل',
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'رقم الهاتف:',
                        style: LightTheme.textStyle(
                            fontSize: 16, color: LightTheme.textBlack),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: widget.cartController.phoneController,
                          decoration: const InputDecoration(
                            hintText: 'ادخل رقم الهاتف',
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'الاسم العنوان:',
                        style: LightTheme.textStyle(
                            fontSize: 16, color: LightTheme.textBlack),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: widget.cartController.addressController,
                          decoration: const InputDecoration(
                            hintText: 'ادخل اسم العنوان',
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          decoration: const InputDecoration(
                            hintText: 'اختر طريقة الدفع',
                          ),
                          items: const [
                            DropdownMenuItem(
                              child: Text('بطاقة ائتمانية'),
                              value: 'creditCard',
                            ),
                            DropdownMenuItem(
                              child: Text('بطاقة خصوم'),
                              value: 'discountCard',
                            ),
                            DropdownMenuItem(
                              child: Text('نقدية'),
                              value: 'cash',
                            ),
                          ],
                          onChanged: (value) {
                            widget.cartController.paymentController.text =
                                value as String;
                          },
                        ),
                      )
                    ],
                  ),
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
                        '${widget.totalPrice}',
                        style: LightTheme.textStyle(
                            fontSize: 16, color: LightTheme.main),
                      )
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (widget.cartController.cart?.isNotEmpty ?? false) {
                    widget.cartController.addOrder(context);
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
