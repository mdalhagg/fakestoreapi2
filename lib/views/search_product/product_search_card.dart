import 'package:fakestoreapi/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class ProductSearchCard extends StatelessWidget {
  const ProductSearchCard({
    super.key,
    required this.name,
    required this.controller,
  });

  final TextEditingController name;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: name,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(
            color: LightTheme.textBlack,
            fontSize: 16,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: LightTheme.main,
                width: 2.0,
                strokeAlign: 20,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: LightTheme.textBlack,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          icon: const Icon(Icons.search),
          hintText: 'بحث عن منتج',
        ),
        onChanged: (value) async {
          name.text = value;
          await controller.getSearchData();
        },
      ),
    );
  }
}
