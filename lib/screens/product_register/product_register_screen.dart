import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/product_model.dart';

class ProductRegisterScreen extends StatefulWidget {
  const ProductRegisterScreen({super.key});
  @override
  State<ProductRegisterScreen> createState() => _ProductRegisterScreenState();
}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {
  String? imageUrl;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  void pickImage() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text('이미지 선택'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                imageUrl = 'https://picsum.photos/200/300';
              });
              Navigator.pop(context);
            },
            child: const Text('선택'),
          ),
        ],
      ),
    );
  }

  void submit() {
    final product = ProductModel(
      id: DateTime.now().toIso8601String(),
      name: nameController.text,
      imageUrl: imageUrl ?? '',
      price: int.tryParse(priceController.text) ?? 0,
      description: descController.text,
    );
    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상품 등록')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.white, // 배경 흰색
            alignment: Alignment.center,
            child: imageUrl == null
              ? const Text('상품 이미지 없음')
              : Image.network(imageUrl!, fit: BoxFit.contain), // 빈 공간 유지
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: pickImage,
            child: const Text('사진 선택'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: '상품 이름'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly], // 숫자만
                  decoration: const InputDecoration(labelText: '상품 가격'),
                ),
              ),
              const SizedBox(width: 8),
              const Text('원', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descController,
            decoration: const InputDecoration(labelText: '상품 설명'),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: submit,
              child: const Text('등록'),
            ),
          ),
        ]),
      ),
    );
  }
}
