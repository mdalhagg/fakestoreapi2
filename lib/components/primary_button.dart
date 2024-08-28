import 'package:flutter/material.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.label,
    this.color,
    this.textColor,
    this.fontSize,
  });
  final void Function() onTap;
  final String label;
  final Color? color;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: LightTheme.main,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              label,
              style: LightTheme.textStyle(
                  color: LightTheme.textWhite, fontSize: 19),
            ),
          ),
        ),
      ),
    );
  }
}
