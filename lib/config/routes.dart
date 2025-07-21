import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/product_register/product_register_screen.dart';
import '../screens/product_detail/product_detail_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (_) => const LoginScreen(),
  '/home': (_) => const HomeScreen(),
  '/register': (_) => const ProductRegisterScreen(),
  '/detail': (_) => const ProductDetailScreen(),
};
