import 'dart:developer';

import 'package:fakestoreapi/models/product.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fakestoreapi/apis.dart';
import 'package:fakestoreapi/services/http.dart';

class HomeController extends ChangeNotifier {
  final RefreshController refreshController = RefreshController();
  bool isLoading = false,
      hasError = false,
      noData = false,
      hasErrorNext = false;
  String? error;
  List<Product> home = [];
  List<Product> temp = [];

  Future<void> refresh() async {
    isLoading = true;
    noData = false;
    hasError = false;
    notifyListeners();
    await getHomeData();

    refreshController.refreshCompleted();
    notifyListeners();
  }

  void init() {
    isLoading = true;
    noData = false;
    hasError = false;
    notifyListeners();
    getHomeData();
    notifyListeners();
  }

  Future<void> getHomeData() async {
    isLoading = true;
    noData = false;
    hasError = false;
    notifyListeners();
    await HTTPService.get(
      API.products,
    ).then(
      (value) async {
        hasError = false;
        isLoading = false;
        if (value.isNotEmpty) {
          home = List<Product>.from(
            value.map(
              (e) => Product.fromJson(e),
            ),
          );

          notifyListeners();
        } else {
          // home = Home();
          noData = true;
          notifyListeners();
        }
      },
    ).onError(
      (e, s) {
        hasError = true;
        log("$e", stackTrace: s);
        notifyListeners();
      },
    );
    if (hasError) {
      await HTTPService.getCachedResponse(url: API.products)
          .then((value) async {
        if (value.isNotEmpty) {
          home = List<Product>.from(
            value.map(
              (e) => Product.fromJson(e),
            ),
          );

          notifyListeners();
        } else {
          noData = true;
          // home = Home();
        }
        isLoading = false;
      });
    }
    notifyListeners();
  }

  getSearchData() {}
}
