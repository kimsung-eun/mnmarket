import 'package:flutter/material.dart';
import 'config/routes.dart'; // 직접 라우트 정의한 경우
import 'screens/product_detail/product_detail_screen.dart';
import 'models/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyProduct = ProductModel(
      id: 1,
      name: '테스트 상품',
      price: 9900,
      imageUrl: '',
      description: '이건 테스트용 상품입니다.\n상품 상세 페이지 테스트 중!',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MNMarket',
      initialRoute: '/', // 또는 '/login'
      routes: appRoutes,
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => const ProductDetailScreen(),
            settings: RouteSettings(arguments: dummyProduct),
          );
        }
        return null;
      },
    );
  }
}
