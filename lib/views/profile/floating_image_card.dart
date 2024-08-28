import 'package:flutter/material.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class FloatingImageCard extends StatelessWidget {
  const FloatingImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 100,
      right: 100,
      child: Container(
        width: 100,
        height: 100,
        transform: Matrix4.translationValues(0, -60, 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: LightTheme.main,
          ),
          image: const DecorationImage(
            image: AssetImage('assets/img/logo.png'),
            fit: BoxFit.contain,
          ),
          color: LightTheme.background,
        ),
      ),
    );
  }
}
