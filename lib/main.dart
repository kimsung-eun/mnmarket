import 'package:flutter/material.dart';
import 'config/routes.dart'; // routes.dart 파일에 정의된 라우트 맵
// 필요하다면 import 추가

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MNMarket',
      initialRoute: '/login', // ✅ 앱 시작은 로그인 화면부터
      routes: appRoutes, // ✅ routes.dart에서 라우트 맵 정의
    );
  }
}
