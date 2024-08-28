import 'package:flutter/material.dart';

class CartDialog {
  static Future<void> cartDeleteDialogConfirm(
      BuildContext context, VoidCallback onTap) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل تريد حذف المنتج؟'),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: onTap,
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> cartDialogConfirm(
      BuildContext context, Function onTap) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تنبيه!!!'),
          content: const Text(
              'لا يمكن الطلب من اكثر من محل ، هل تريد افراغ السله و اضافه هذا المنتج ؟'),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('تاكيد'),
              onPressed: () {
                onTap();
              },
            ),
          ],
        );
      },
    );
  }
}
