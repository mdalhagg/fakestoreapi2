import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:fakestoreapi/components/snackbar.dart';
import 'package:fakestoreapi/controllers/user.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final UserController userController = UserController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int length = 0;

  @override
  void initState() {
    super.initState();
    userController.addListener(() {
      setState(() {});
    });
    // Future.delayed(const Duration(seconds: 3), () {
    //   context.go('/home');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: LightTheme.background,
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              top: 0,
              end: 0,
              child: Image.asset(
                'assets/img/splash/top.png',
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              start: 0,
              child: Image.asset(
                'assets/img/splash/bottom.png',
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        width: 340,
                        decoration: BoxDecoration(
                          color: LightTheme.background,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              'تسجيل الدخول',
                              style: LightTheme.textStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 15),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    labelText: 'اسم المستخدم',
                                    labelStyle: LightTheme.textStyle(
                                        fontSize: 20,
                                        color: LightTheme.textGray3),
                                    focusColor: LightTheme.main,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: LightTheme.main),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  autofocus: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    labelText: 'كلمه السر',
                                    labelStyle: LightTheme.textStyle(
                                        fontSize: 20,
                                        color: LightTheme.textGray3),
                                    focusColor: LightTheme.main,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: LightTheme.main),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  autofocus: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await userController.login(
                                  context,
                                  username: usernameController.text ?? '',
                                  password: passwordController.text ?? '',
                                );
                                if (userController.token != '') {
                                  context.push('/home');
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                width: 160,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: LightTheme.main,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'تسجيل الدخول',
                                  style: LightTheme.textStyle(
                                      fontSize: 14,
                                      color: LightTheme.textWhite),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -35,
                        right: MediaQuery.of(context).size.width / 2 - 100,
                        left: MediaQuery.of(context).size.width / 2 - 100,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: LightTheme.background,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Image.asset(
                              'assets/logo.jpeg',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      'العوده للرئيسية',
                      style: LightTheme.textStyle(
                              fontSize: 14, color: LightTheme.main)
                          .copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: LightTheme.main,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/privacy_policy');
                    },
                    child: Text(
                      'سياسه الخصوصيه',
                      style: LightTheme.textStyle(
                              fontSize: 14, color: LightTheme.main)
                          .copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: LightTheme.main,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
