import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/product_detail/product_detail_screen.dart';
import '../screens/product_register/product_register_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(), // ✅ 홈을 루트로 설정
  '/login': (context) => const LoginScreen(),
  '/detail': (context) => const ProductDetailScreen(),
  '/register': (context) => const ProductRegisterScreen(),
};
