import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fakestoreapi2/apis.dart';
import 'package:fakestoreapi2/components/dialogs/error.dart';
import 'package:fakestoreapi2/components/dialogs/error_snackbar.dart';
import 'package:fakestoreapi2/components/dialogs/loading.dart';
import 'package:fakestoreapi2/components/snackbar.dart';
import 'package:fakestoreapi2/models/http_exception.dart';
import 'package:fakestoreapi2/models/user.dart';
import 'package:fakestoreapi2/router.dart';
import 'package:fakestoreapi2/services/http.dart';

class UserController extends ChangeNotifier {
  UserController();

  bool isLoading = false, hasError = false;
  String? error;
  User? user;
  String token = '';
  bool otpSuccess = false, noData = false;

  int referrals = 0;

  Future<void> load() async {
    user = settingsController.user;
  }

  Future<void> info() async {
    isLoading = true;
    noData = false;
    hasError = false;
    notifyListeners();
    await HTTPService.get(
      API.info + '${settingsController.user?.id}',
      headers: {
        // HttpHeaders.authorizationHeader: "Bearer ${settingsController.user?.token}",
        HttpHeaders.acceptHeader: "application/json",
      },
    ).then(
      (value) async {
        User temp = User.fromJson(value['data']);
        temp.token = settingsController.user?.token;
        await settingsController.updateUser(temp.toJson()).then(
          (value) async {
            await settingsController.loadSettings();
            user = settingsController.user;
            settingsController.notifyListeners();
            notifyListeners();
          },
        ).onError(
          (e, s) {
            throw "$e";
          },
        );
        otpSuccess = true;
        isLoading = false;
      },
    ).onError(
      (e, s) {
        error = "$e";
        isLoading = false;
        hasError = true;
        log("$e", stackTrace: s);
      },
    );
    if (hasError) {
      await HTTPService.getCachedResponse(url: API.info).then(
        (value) async {
          User temp = User.fromJson(value['data']);
          temp.token = settingsController.user?.token;
          await settingsController.updateUser(temp.toJson()).then(
            (value) async {
              await settingsController.loadSettings();
              user = settingsController.user;
              settingsController.notifyListeners();
              notifyListeners();
            },
          ).onError(
            (e, s) {
              throw "$e";
            },
          ).onError((error, stackTrace) {
            noData = true;
          });
          otpSuccess = true;
          isLoading = false;
        },
      ).onError(
        (e, s) {
          isLoading = false;
          hasError = true;
          noData = true;
          log("$e", stackTrace: s);
          notifyListeners();
        },
      );
    }
    notifyListeners();
  }

  Future<void> login(
    BuildContext context, {
    required String username,
    required String password,
  }) async {
    LoadingDialog.loadingDialog(context);
    // delete + from phone

    await HTTPService.post(
      API.auth,
      body: jsonEncode(
        {
          'username': username,
          'password': password
        },
      ),
    ).then(
      (value) {
        if (value['token'] == null) {
          throw 'فشل تسجيل الدخول، يرجى المحاولة مرة أخرى لاحقا';
        }
        token = value['token'];
        otpSuccess = true;
        notifyListeners();
        Navigator.of(context).pop();
      },
    ).onError(
      (e, s) {
        error = "$e";
        Navigator.of(context).pop();
        ErrorSnackBar.show(context, "$e");
        log("$e", stackTrace: s);
      },
    );
  }
  

  Future<void> update(
    BuildContext context, {
    required String name,
    String? phone,
    bool redirect = true,
  }) async {
    settingsController.loadSettings();
    LoadingDialog.loadingDialog(context);
    var body = {
      'name': name,
      // 'phone': phone,
    };

    await HTTPService.post(
      API.updateProfile + '${settingsController.user?.id}',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${settingsController.user?.token}",
      },
      body: jsonEncode(body),
    ).then(
      (response) async {
        if (response['status'] == false) {
          context.pop();
          errorSnackbar(
            context,
            message: "${response['message'] ?? 'حدث خطأ أثناء تحديث بيانات المستخدم'}",
          );
          return;
        }
        User temp = User.fromJson(response);
        temp.token = settingsController.user?.token;
        await settingsController.updateUser(temp.toJson()).then(
          (value) async {
            await settingsController.loadSettings();
            user = settingsController.user;
            settingsController.notifyListeners();
            notifyListeners();
            if (!context.mounted) return;
            context.pop();
            if (redirect) context.go('/');
          },
        ).onError(
          (e, s) {
            throw "$e";
          },
        );
      },
    ).onError(
      (HTTPException e, s) {
        error = "$e";
        Navigator.of(context).pop();
        errorSnackbar(context, message: e.message.toString());
        log("$e", stackTrace: s, name: "UserController");
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    LoadingDialog.loadingDialog(context);
    await settingsController.removeUser().then((value) async {
      if (!context.mounted) return;
      // empty cart
      if (context.mounted) {
        await settingsController.clearCart();
      }
      Navigator.of(context).pop();

      context.go('/');
    }).onError((e, s) {
      error = "$e";
      log("$e", stackTrace: s, name: "UserController");
    });
  }
}
