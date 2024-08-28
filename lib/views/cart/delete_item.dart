import 'package:flutter/material.dart';
import 'package:fakestoreapi/components/dialogs/cart_delete_dialog.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class DeleteItemCard extends StatelessWidget {
  const DeleteItemCard({
    super.key,
    required this.cartController,
    required this.index,
  });

  final CartController cartController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      right: 5,
      child: InkWell(
        onTap: () async {
          await CartDialog.cartDeleteDialogConfirm(context, () async {
            await cartController.remove(context, index: index);
            Navigator.pop(context);
          });
        },
        child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: LightTheme.red,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(Icons.close, size: 18, color: LightTheme.background)),
      ),
    );
  }
}
