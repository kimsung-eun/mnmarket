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
  String selectedCategory = 'dog';
  final Color brandRed = const Color(0xFFAD2426);

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
    if (nameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        descController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('입력 오류'),
          content: const Text('모든 항목을 입력해주세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
      return;
    }

    final product = ProductModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: nameController.text.trim(),
      imageUrl: imageUrl ?? '',
      price: int.tryParse(priceController.text.trim()) ?? 0,
      description: descController.text.trim(),
      category: selectedCategory,
    );
    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 등록'),
        backgroundColor: brandRed,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.center,
            child: imageUrl == null
                ? const Text('상품 이미지 없음')
                : Image.network(imageUrl!, fit: BoxFit.contain),
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: pickImage, child: const Text('사진 선택')),
          const SizedBox(height: 16),
          TextField(controller: nameController, decoration: const InputDecoration(labelText: '상품 이름')),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          const SizedBox(height: 20),
          const Text('카테고리 선택', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 6),
          DropdownButton<String>(
            value: selectedCategory,
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: 'dog', child: Text('강아지')),
              DropdownMenuItem(value: 'cat', child: Text('고양이')),
            ],
            onChanged: (v) => setState(() => selectedCategory = v!),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: brandRed,
                foregroundColor: Colors.white,
              ),
              child: const Text('등록', style: TextStyle(fontSize: 16)),
            ),
          ),
        ]),
      ),
    );
  }
}
