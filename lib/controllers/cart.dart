// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fakestoreapi2/components/dialogs/loading.dart';
import 'package:fakestoreapi2/components/snackbar.dart';
import 'package:fakestoreapi2/models/product_cart.dart';
import 'package:fakestoreapi2/router.dart';
import 'package:fakestoreapi2/services/settings.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  CartController();
  final SettingsService _settingsService = SettingsService();
  bool isLoading = false;
  bool? isSyncing, hasError;
  String? error;
  List<ProductCart>? cart = settingsController.cart;
  int total = 0;
  int discount = 0;
  int deliveryPrice = 0;
  int totalPrice = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  var marketBox = Hive.box('market');

  Future<void> load() async {
    await settingsController.loadSettings();
    // await addressController.get();
    notifyListeners();
  }

  Future<void> add(
    BuildContext? context, {
    required ProductCart item,
  }) async {
    await _settingsService.addToCart(item).then(
      (value) async {
        await load().then((value) async {
          if (context != null) {
            ScaffoldMessenger.of(context).clearSnackBars();
            LoadingDialog.loadingDialog(context);
            successSnackbar(context, message: "تمت اضافة المنتج بنجاح");
            context.pop();
          }
          await settingsController.loadSettings();
          notifyListeners();
        });
      },
    ).onError(
      (e, s) {
        if (context != null) {
          ScaffoldMessenger.of(context).clearSnackBars();
          errorSnackbar(context, message: e.toString());
        }
        log("$e", stackTrace: s, name: "CartController");
      },
    );
    // log("added to cart ${item.toJson()}");

    notifyListeners();
  }

  Future<void> clear(BuildContext context) async {
    await _settingsService.clearCart().then(
      (value) async {
        marketBox.delete('market');
        await load().then((value) async {
          ScaffoldMessenger.of(context).clearSnackBars();
          successSnackbar(context, message: "تمت افراغ السلة بنجاح");
          await settingsController.loadSettings();
          notifyListeners();
        });
      },
    ).onError(
      (e, s) {
        ScaffoldMessenger.of(context).clearSnackBars();
        errorSnackbar(context, message: e.toString());
        log("$e", stackTrace: s, name: "CartController");
      },
    );
  }

  Future<void> remove(
    BuildContext context, {
    required int index,
  }) async {
    isLoading = true;
    await _settingsService.removeItemFromCart(index).then(
      (value) async {
        await load().then((value) async {
          if (context != null) {
            settingsController.cart?.isEmpty == true
                ? marketBox.delete('market')
                : null;
            ScaffoldMessenger.of(context).clearSnackBars();
            LoadingDialog.loadingDialog(context);
            successSnackbar(context, message: "تم حذف المنتج بنجاح");
            context.pop();
          }
          await settingsController.loadSettings();
          cart = settingsController.cart;
          isLoading = false;
          notifyListeners();
        });
      },
    ).onError(
      (e, s) {
        ScaffoldMessenger.of(context).clearSnackBars();
        errorSnackbar(context, message: e.toString());
        log("$e", stackTrace: s, name: "CartController");
      },
    );
    isLoading = false;
  }

  Future<void> changeQuantity(
    BuildContext context, {
    required int index,
    required int quantity,
  }) async {
    await _settingsService.cartChangeProductQuantity(index, quantity).then(
      (value) async {
        await load().then((value) async {
          await settingsController.loadSettings();
          cart = settingsController.cart;
          // await getDeliveryPrice(
          //   context,
          //   products: jsonEncode(cart),
          //   address_id:
          //       (addressController.addresses?.first.id.toString() ?? '0'),
          // ).then((value) {
          //   invoice = invoice;
          //   total = invoice?.order ?? 0;
          //   discount = invoice?.discount ?? 0;
          //   deliveryPrice = invoice?.deliveryPrice ?? 0;
          //   totalPrice = total + deliveryPrice - discount;
          //   log('$totalPrice');
          //   orderPreparation = orderPreparation;
          // });
          notifyListeners();
        });
        isLoading = false;
      },
    ).onError(
      (e, s) {
        isLoading = false;
        log("$e", stackTrace: s, name: "CartController");
      },
    );
    notifyListeners();
  }

  addOrder(BuildContext context) async {
    notifyListeners();
    // add order on hive storage
    var ordersBox = Hive.box('orders');
    var order = Order(
      id: '1',
      deliveryPrice: totalPrice.toString(),
      payment: "",
      discount: "",
      cart: cart,
    );

    // clear cart
    await _settingsService.clearCart();
    await settingsController.loadSettings();
    ordersBox.add(order.toJson());
    notifyListeners();
    context.go('/home');

    successSnackbar(context, message: "تمت الاضافة بنجاح");
  }

  // Future<void> addFromOrder(Order? order) async {
  //   for (int i = 0; i < (order?.orderDetails?.length ?? 0); i++) {
  //     OrderDetails? orderDetails = order?.orderDetails?[i];
  //     await add(
  //       null,
  //       item: ProductCart(
  //         productId: orderDetails?.productId,
  //         productOptionId: orderDetails?.productOptionId,
  //         quantity: orderDetails?.quantity,
  //         name: orderDetails?.product?.name,
  //         media: orderDetails?.product?.media,
  //         productOption: orderDetails?.product?.productOption?.firstWhere(
  //           (element) => element.id == orderDetails.productOptionId,
  //           orElse: () => ProductOption(),
  //         ),
  //         optionDetails: orderDetails?.product?.optionDetails?.toList(),
  //       ),
  //       shop: order?.shop,
  //     );
  //   }
  // }
}

class Order {
  String? id;
  String? address;
  String? order;
  String? discount;
  String? deliveryPrice;
  String? payment;
  List<ProductCart>? cart;

  Order({
    this.id,
    this.address,
    this.order,
    this.discount,
    this.deliveryPrice,
    this.payment,
    this.cart,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    order = json['order'];
    discount = json['discount'];
    deliveryPrice = json['deliveryPrice'];
    payment = json['payment'];
    if (json['cart'] != null) {
      cart = <ProductCart>[];
      json['cart'].forEach((v) {
        cart!.add(new ProductCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['order'] = this.order;
    data['discount'] = this.discount;
    data['deliveryPrice'] = this.deliveryPrice;
    data['payment'] = this.payment;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
