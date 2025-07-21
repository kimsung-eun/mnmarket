import 'package:flutter/material.dart';
import 'config/routes.dart';
import 'config/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    title: '쇼핑몰 앱',
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    initialRoute: '/login',
    routes: appRoutes,
  );
}
