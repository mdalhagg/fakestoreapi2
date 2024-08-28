import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fakestoreapi/controllers/settings.dart';
import 'package:fakestoreapi/views/home_panel.dart';
import 'package:fakestoreapi/views/splash_screen.dart';
import 'package:fakestoreapi/views/cart_screen.dart';
// import 'package:fakestoreapi/screens/map_screen.dart';
import 'package:fakestoreapi/views/search_product_screen.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(microseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 700),
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          reverseTransitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/search-products',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(microseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 700),
          key: state.pageKey,
          child: const SearchProductsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/cart',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(microseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 700),
          key: state.pageKey,
          child: const CartScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

final SettingsController settingsController = SettingsController();
