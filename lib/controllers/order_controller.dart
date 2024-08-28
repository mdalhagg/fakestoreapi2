import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fakestoreapi/apis.dart';
import 'package:fakestoreapi/components/snackbar.dart';
import 'package:fakestoreapi/router.dart';
import 'package:fakestoreapi/services/http.dart';

class OrderController extends ChangeNotifier {
  OrderController();

  RefreshController refreshController = RefreshController();

  bool isLoading = false, hasError = false;
  bool otpSuccess = false, noData = false;
  String? error;
  List<int>? removeFromCart;
  File? transferImage;
  final TextEditingController noteController = TextEditingController();
  final TextEditingController couponController = TextEditingController();
  get price => null;
  bool payFromWallet = false;
  int? selectedAddress, selectedPayment, selectedAccount;
  DateTime selectedDateTime = DateTime.now();
  // Coupon? coupon;
  var marketBox = Hive.box('market');

  refresh() async {
    noData = false;
    isLoading = false;
    hasError = false;

    notifyListeners();
    refreshController.refreshCompleted();
    notifyListeners();
  }

  void selectDateTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime initialDate =
        selectedDateTime != null && selectedDateTime.isBefore(now)
            ? DateTime(now.year, now.month, now.day, now.hour, now.minute)
            : selectedDateTime;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      TimeOfDay initialTime = selectedDateTime.isBefore(now)
          ? TimeOfDay(hour: now.hour, minute: now.minute)
          : TimeOfDay.fromDateTime(selectedDateTime);

      final selectedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (selectedTime != null) {
        final newDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        selectedDateTime = newDateTime;
      }
    }
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await HTTPService.multipartPost(
      API.orderSubmit,
      headers: {},
      data: <String, String>{
        'order': jsonEncode({
          'note': noteController.text,
          'products': await settingsController.getCartJson() ?? '',
          if (couponController.text.isNotEmpty) "code": couponController.text
        }),
      },
      files: [
        if (transferImage != null)
          await http.MultipartFile.fromPath(
            'image',
            transferImage?.path ?? '',
          ),
      ],
    ).then(
      (value) async {
        if (value.isNotEmpty) {
          isLoading = false;
          hasError = true;
          notifyListeners();

          successSnackbar(context, message: "تم ارسال الطلب بنجاح");
          // clear Cart
          await settingsController.clearCart();
          // clear shop data
          var marketBox = Hive.box('market');
          await marketBox.delete('market');
          context.go('/home');
        } else {
          isLoading = false;
          errorSnackbar(context, message: value['message']);
        }
      },
    ).onError(
      (e, s) {
        // Navigator.of(context).pop();

        errorSnackbar(context, message: 'حدث خطأ ما');
        isLoading = false;
        hasError = true;
        log("$e", stackTrace: s);
      },
    );
    notifyListeners();
  }

 
}
