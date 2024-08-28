import 'package:flutter/material.dart';

class InfoDialog {
  void infoDialog(BuildContext context,title,content ,Function onTap) {
    showDialog(
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
              child: const Text('حذف'),
              onPressed: () async {
                await onTap();
              },
            ),
          ],
        );
      },
    );
  }
}
