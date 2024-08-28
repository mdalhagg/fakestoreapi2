import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginDialog {
  void loginDialogConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تسجيل الدخول'),
          content: const Text('يرجى تسجيل الدخول اولاَ'),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('دخول'),
              onPressed: () {
                context.push('/login');
              },
            ),
          ],
        );
      },
    );
  }

  void addressDialogConfirm(BuildContext context, VoidCallback onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('استكمال بيانات التسجيل'),
          content: const Text('يرجى أضافة عنوان توصيل افتراضي اولاَ'),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('أضافة'),
              onPressed: () {
                onTap();
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
