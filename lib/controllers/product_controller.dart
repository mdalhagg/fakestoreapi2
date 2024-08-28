import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fakestoreapi/apis.dart';
import 'package:fakestoreapi/models/product.dart';
import 'package:fakestoreapi/services/http.dart';

class ProductController extends ChangeNotifier {
  bool isLoading = false,
      hasError = false,
      isLoadingNext = false,
      noData = false,
      hasErrorNext = false;
  String? error;
  String? nextPageUrl;
  List? category;
  Product? product;
  Product? temp;
  RefreshController refreshController = RefreshController();

  void init(id) async {
    await getProductData();
    notifyListeners();
  }

  Future<void> getProductData() async {
    isLoading = true;
    noData = false;
    hasError = false;
    notifyListeners();
    await HTTPService.get(
      API.products,
    ).then(
      (value) async {
        if (value.isNotEmpty) {
          category = List.from(
            value.map(
              (e) => jsonDecode(e),
            ),
          );
          product = Product.fromJson(value['products']);

          refreshController.refreshCompleted();
          isLoading = false;
          hasError = false;
        }
        isLoading = false;
        // notifyListeners();
      },
    ).onError(
      (e, s) {
        isLoading = false;
        hasError = true;
        log("$e", stackTrace: s);
        refreshController.refreshFailed();
        // notifyListeners();
      },
    );
    if (hasError) {
      await HTTPService.getCachedResponse(url: API.products)
          .then((value) {
        if (value != null) {
          category = List.from(
            value['categories'].map(
              (e) => jsonDecode(e),
            ),
          );
          product = Product.fromJson(value);

          refreshController.refreshCompleted();

          isLoading = false;
          hasError = false;
        } else {
          isLoading = false;
          noData = true;
          refreshController.refreshFailed();
        }
        isLoading = false;
      }).onError(
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

}
