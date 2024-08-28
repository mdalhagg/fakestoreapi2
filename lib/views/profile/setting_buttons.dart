import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:fakestoreapi/controllers/user.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class SettingCardButtons extends StatelessWidget {
  const SettingCardButtons({
    super.key,
    required this.userController,
  });

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('تأكيد الخروج'),
                  content: const Text('هل تريد تسجيل الخروج من الحساب؟'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('الغاء'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('تسجيل الخروج'),
                      onPressed: () {
                        userController.logout(
                          context,
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: FaIcon(
            FontAwesomeIcons.doorOpen,
            color: LightTheme.main,
            size: 20,
          ),
        ),
       
      ],
    );
  }
}
