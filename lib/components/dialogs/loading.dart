import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class LoadingDialog {
  static Future<void> loadingDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          child: SimpleDialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: LightTheme.main,
                  size: 100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
