import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fakestoreapi/app.dart';

void main() async {
  await Hive.initFlutter().then((_) async {
    await Hive.openBox('settings');
    await Hive.openBox('cart');
    await Hive.openBox('user');
    await Hive.openBox('http_cache');
    await Hive.openBox('market');
    await Hive.openBox('address');
    await Hive.openBox('currency');
    // var a = Hive.box('http_cache').toMap();
    // log("$a", name: "main");
  });
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  const overlayStyle = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(overlayStyle);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}
