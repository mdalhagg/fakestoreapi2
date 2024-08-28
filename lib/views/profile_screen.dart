import 'package:flutter/material.dart';
import 'package:fakestoreapi/controllers/user.dart';
import 'package:fakestoreapi/router.dart';
import 'package:fakestoreapi/views/profile/floating_profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static UserController userController = UserController();

  @override
  void initState() {
    super.initState();
    settingsController.addListener(() {
      if (mounted) setState(() {});
    });
    userController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    userController.info();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        extendBody: true,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: 300,
              height: 350,
              child: FloatingProfileCard(userController: userController),
            ),
          ),
        ));
  }
}
