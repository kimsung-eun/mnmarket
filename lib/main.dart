import 'package:flutter/material.dart';
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
      imageUrl: '', // 이미지 없이 테스트할 경우 빈 문자열
      description: '이건 테스트용 상품입니다.\n상품 상세 페이지 테스트 중!',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
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
