import 'package:flutter/material.dart';
import 'config/routes.dart'; // 경로는 실제 파일 위치에 맞게 조정하세요

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
      initialRoute: '/login', // 로그인 화면부터 시작
      routes: appRoutes, // routes.dart에 정의된 경로들 연결
    );
  }
}
