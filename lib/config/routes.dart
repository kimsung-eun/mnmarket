import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/product_detail/product_detail_screen.dart';
import '../screens/product_register/product_register_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(),
  '/detail': (context) => const ProductDetailScreen(),
  '/register': (context) => const ProductRegisterScreen(),
};
