import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RegisterButton({super.key, required this.onPressed});
  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: onPressed, child: const Text('등록')),
      ),
    );
  }
}
