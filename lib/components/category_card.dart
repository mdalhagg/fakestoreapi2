import 'package:flutter/material.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard(this.categories, this.index, {super.key});
  final List? categories;
  final int? index;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.categories?[widget.index!] ?? 0 + 1}',
          style: LightTheme.textStyle(fontSize: 14)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
