import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/logo.png', width: 120, height: 120),
          const SizedBox(height: 32),
          const TextField(decoration: InputDecoration(labelText: '이메일', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          const TextField(obscureText: true, decoration: InputDecoration(labelText: '비밀번호', border: OutlineInputBorder())),
          const SizedBox(height: 24),
          SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton(
    onPressed: () => Navigator.pushReplacementNamed(context, '/'),
    child: const Text('로그인'),
  ),
),
        ]),
      ),
    );
  }
}
