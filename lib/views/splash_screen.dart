import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fakestoreapi2/router.dart';
import 'package:fakestoreapi2/theme/light_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    settingsController.addListener(() {
      if (mounted) {
        settingsController.loadSettings();
        setState(() {});
      }
    });
    Future.delayed(const Duration(milliseconds: 4000), () {
      context.pushReplacement('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: LightTheme.background,
        ),
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Image(image: AssetImage('assets/logo.jpeg')),
          ),
        ]),
      ),
    );
  }
}
