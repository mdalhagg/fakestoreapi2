import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fakestoreapi/models/product_cart.dart';

class SettingsService {
  var settingsBox = Hive.box('settings');
  var cartBox = Hive.box('cart');
  var userBox = Hive.box('user');
  var marketBox = Hive.box('market');

  Future<void> printAll() async {
    // log("settings: ${settingsBox.toMap().toString()}", name: "SettingsService");
    // log("cart: ${cartBox.toMap().toString()}", name: "SettingsService");
    // log("user: ${userBox.toMap().toString()}", name: "SettingsService");
  }

  Future<ThemeMode> themeMode() async {
    String? theme = await settingsBox.get('theme');
    if (theme == 'system') {
      return ThemeMode.system;
    } else if (theme == 'light') {
      return ThemeMode.light;
    } else if (theme == 'dark') {
      return ThemeMode.dark;
    } else {
      // return ThemeMode.system;
      return ThemeMode.light;
    }
  }

  Future<Locale> locale() async {
    String? data = await settingsBox.get('locale');

    return data != null ? Locale(data, '') : const Locale('ar', '');
  }

  Future<bool> intro() async {
    var data = await settingsBox.get('intro');

    return data != null ? data == 'true' : false;
  }



  // Future http(url) async {
  //   var httpBox = Hive.box(url);
  //   var data = await httpBox.get(url);
  //   if (data != null) {
  //     data = data?.replaceAll("\\", "");
  //     data = data.substring(1, data.length - 1);
  //     // log(data.toString());
  //     // ignore: prefer_typing_uninitialized_variables
  //     var http;
  //     try {
  //       http = jsonDecode(data);
  //     } catch (e) {
  //       await httpBox.delete(url);
  //       return null;
  //     }

  //     return http;
  //   } else {
  //     return null;
  //   }
  // }

  // Future<void> updateHttp(url, data) async {
  //   var httpBox = Hive.box(url);
  //   await httpBox.put(
  //     url,
  //     jsonEncode(data),
  //   );
  // }
  // // getHttp(url)

  Future<void> updateThemeMode(ThemeMode theme) async => await settingsBox.put(
        "theme",
        theme.name,
      );

  Future<void> updateLocale(Locale locale) async => await settingsBox.put(
        "locale",
        locale.languageCode,
      );



  Future<String?> referralCode() async => await settingsBox.get(
        'referralCode',
        defaultValue: null,
      );

  Future<void> setReferralCode(String id) async =>
      await settingsBox.put('referralCode', id);

  Future<void> removeReferralCode() async =>
      await settingsBox.delete('referralCode');

  Future<List<ProductCart>?> cart() async {
    List<ProductCart>? cart;
    String? data = await cartBox.get('cart');
    // log("${data.runtimeType}", name: "SettingsService:cart");
    // log("cart Data: fromBox: $data", name: "SettingsService:cart");
    try {
      List<dynamic> temp = jsonDecode(data ?? '');
      // log("jsonDecoded: $temp", name: "SettingsService:cart");
      cart = [];
      for (int i = 0; i < temp.length; i++) {
        cart.add(ProductCart.fromJson(temp[i]));
      }
    } catch (e) {
      removeCart();
    }

    return cart;
  }

  Future<void> removeCart() async => await cartBox.clear();

  Future<void> removeItemFromCart(int index) async {
    List<ProductCart> cart = [];
    var data = await cartBox.get('cart');
    if (data != null) {
      data = jsonDecode("$data");
      // log(data.toString());
      cart = List<ProductCart>.from(
        data.map(
          (item) => ProductCart.fromJson(item),
        ),
      );
      cart.removeAt(index);
      var back = cart.map((e) => e.toJson()).toList();
      cartBox.put('cart', jsonEncode(back));
    }
  }

  Future<void> addToCart(ProductCart object) async {
    List<ProductCart> cart = [];
    bool isDone = false;
    var data = await cartBox.get('cart');
    // log("cart Data: $data");
    if (data != null) {
      // log("checking if item isn't in cart");
      data = jsonDecode("$data");
      // log(data.toString());
      cart = List<ProductCart>.from(
        data.map(
          (item) => ProductCart.fromJson(item),
        ),
      );
      // log("iterating items...");
      Iterable<ProductCart> contain = [];
      contain = cart.where(
        (element) => element.productId == object.productId,
      );
      if (!isDone) {
        // log("item not found, adding item...");
        cart.add(object);
        var back = cart.map((e) => e.toJson()).toList();
        // log("back: $back");
        cartBox.put('cart', jsonEncode(back));
        // log("done");
      }
    } else {
      cart.add(object);
      var back = cart.map((e) => e.toJson()).toList();
      await cartBox.put('cart', jsonEncode(back)).then((value) => log('done'));
    }
  }

  Future<void> cartChangeProductQuantity(int index, int quantity) async {
    List<ProductCart> cart = [];
    var data = await cartBox.get('cart');
    if (data != null) {
      data = jsonDecode("$data");
      // log(data.toString());
      cart = List<ProductCart>.from(
        data.map(
          (item) => ProductCart.fromJson(item),
        ),
      );
      cart[index].quantity = quantity;
      var back = cart.map((e) => e.toJson()).toList();
      // log(back.toString());
      cartBox.put('cart', jsonEncode(back));
    }
  }

  Future<String?> getCartJson() async {
    var data = await cartBox.get('cart');
    // log("cart Data: $data");

    return data;
  }

  Future<void> clearCart() async => await cartBox.clear();
}
