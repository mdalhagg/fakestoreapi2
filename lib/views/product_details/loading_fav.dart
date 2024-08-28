import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class LoadingFavCard extends StatelessWidget {
  const LoadingFavCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: BoxDecoration(
        color: LightTheme.third,
        borderRadius: BorderRadius.circular(15),
      ),
      transform: Matrix4.translationValues(0, -40, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LoadingAnimationWidget.threeArchedCircle(
            color: LightTheme.main, size: 40),
      ),
    ));
  }
}
