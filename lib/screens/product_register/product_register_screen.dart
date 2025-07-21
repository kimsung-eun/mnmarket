import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductRegisterScreen extends StatefulWidget {
  const ProductRegisterScreen({super.key});
  @override State<ProductRegisterScreen> createState() => _S();
}

class _S extends State<ProductRegisterScreen> {
  String imageUrl = 'https://picsum.photos/200/300';
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  @override Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('상품 등록')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Image.network(imageUrl, height: 200, fit: BoxFit.cover),
        const SizedBox(height: 8),
        ElevatedButton(onPressed: () {/* 팝업 또는 갤러리 선택 로직 */}, child: const Text('사진선택')),
        const SizedBox(height: 16),
        TextField(controller: nameController, decoration: const InputDecoration(labelText: '이름')),
        const SizedBox(height: 12),
        TextField(controller: priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '가격')),
        const SizedBox(height: 12),
        TextField(controller: descController, decoration: const InputDecoration(labelText: '내용')),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              final product = ProductModel(
                id: DateTime.now().toIso8601String(),
                name: nameController.text,
                price: int.tryParse(priceController.text) ?? 0,
                description: descController.text,
                imageUrl: imageUrl,
              );
              Navigator.pop(c, product);
            },
            child: const Text('등록'),
          ),
        ),
      ]),
    ),
  );
}
