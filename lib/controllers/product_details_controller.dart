import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fakestoreapi/apis.dart';
import 'package:fakestoreapi/models/product.dart';
import 'package:fakestoreapi/services/http.dart';

class ProductDetailsController extends ChangeNotifier {
  bool isLoading = false,
      hasError = false,
      isLoadingNext = false,
      noData = false,
      hasErrorNext = false;
  String? error;
  Product product = Product();
  RefreshController refreshController = RefreshController();

  Future<void> getProductDetails(int id) async {
    isLoading = true;
    noData = false;
    hasError = false;
    notifyListeners();
    await HTTPService.get(
      API.productDetails + id.toString(),
    ).then((value) {
      isLoading = false;
      if (value.isNotEmpty) {
        product = Product.fromJson(value['data']);
        notifyListeners();
      }
    }).onError(
      (e, s) {
        isLoading = false;
        hasError = true;
        log("$e", stackTrace: s);
        notifyListeners();
      },
    );
    if (hasError) {
      await HTTPService.getCachedResponse(
              url: API.productDetails + id.toString())
          .then((value) {
        isLoading = false;
        if (value != null) {
          product = Product.fromJson(value['data']);
          notifyListeners();
        } else {
          noData = true;
          product = Product();
        }
      });
    }
    notifyListeners();
  }
}
