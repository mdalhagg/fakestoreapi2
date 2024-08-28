// ignore_for_file: use_build_context_synchronously

import 'package:hive_flutter/hive_flutter.dart';
import 'package:fakestoreapi/models/product_cart.dart';
import 'package:fakestoreapi/services/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsController with ChangeNotifier {
  final SettingsService _settingsService = SettingsService();
  late ThemeMode _themeMode;
  late Locale _locale;
  late bool _intro;
  late List<ProductCart>? _cart;
  late String? _referralCode;
  late String? _http;
  late bool? isOpen;
  bool isLoading = false;

  SettingsController();

  List<ProductCart>? get cart => _cart;
  bool get intro => _intro;
  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  String? get referralCode => _referralCode;
  String? get http => _http;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _locale = await _settingsService.locale();
    _intro = await _settingsService.intro();
    _cart = await _settingsService.cart();
    _referralCode = await _settingsService.referralCode();
    notifyListeners();
  }


  

  Future<void> checkFirstSeen(BuildContext context) async {
    await loadSettings();
    bool seen = intro;

    if (!seen) {
      context.go('/welcome');
    } else {
      context.go('/home');
    }
  }



  Future<void> updateLocale(
    Locale? newLocale,
  ) async {
    if (newLocale == null) return;
    if (newLocale == _locale) return;
    await loadSettings();
    notifyListeners();
    await _settingsService.updateLocale(newLocale);
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(
    ThemeMode? newThemeMode,
  ) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    await loadSettings();
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }


  Future<void> setReferralCode(String? id) async {
    await _settingsService.setReferralCode(id ?? '').then(
      (_) async {
        await loadSettings();
        notifyListeners();
      },
    );
  }

  Future<void> removeReferralCode() async {
    await _settingsService.removeReferralCode().then(
      (_) async {
        await loadSettings();
        notifyListeners();
      },
    );
  }

  Future<void> printAllSettings() async {
    await _settingsService.printAll();
  }

  Future<void> addToCart({
    required ProductCart item,
  }) async =>
      await _settingsService.addToCart(item).then(
        (_) async {
          await loadSettings();
          notifyListeners();
        },
      );

  Future<void> cartChangeProductQuantity(int index, int quantity) async =>
      await _settingsService.cartChangeProductQuantity(index, quantity).then(
        (_) async {
          await loadSettings();
          notifyListeners();
        },
      );

  Future<String?> getCartJson() async => await _settingsService.getCartJson();

  Future<void> removeItemFromCart(int index) async =>
      await _settingsService.removeItemFromCart(index).then(
        (_) async {
          await loadSettings();
          notifyListeners();
        },
      );

  Future<void> clearCart() async =>
      await _settingsService.clearCart().then((_) async {
        var marketBox = Hive.box('market');
        await marketBox.delete('market');
        await loadSettings();
        notifyListeners();
      });
}
