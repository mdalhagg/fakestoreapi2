import 'package:flutter/material.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class AllCategoryCard extends StatefulWidget {
  const AllCategoryCard({super.key});

  @override
  State<AllCategoryCard> createState() => _AllCategoryCardState();
}

class _AllCategoryCardState extends State<AllCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: LightTheme.textGray3,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/img/product_logo.webp',
              width: LightTheme.mediaQueryData.size.width * 0.5,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'الكل',
          style: LightTheme.textStyle(fontSize: 14)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
