import 'package:flutter/material.dart';

class ProductTextFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController, priceController, descriptionController;

  const ProductTextFields({super.key, required this.formKey, required this.nameController, required this.priceController, required this.descriptionController});

  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('상품 이름'),
          TextFormField(controller: nameController, decoration: const InputDecoration(hintText: '이름을 적어주세요'),
              validator: (v) => v == null || v.isEmpty ? '상품 이름을 입력해 주세요' : null),
          const SizedBox(height: 12),
          const Text('상품 가격'),
          Row(children: [
            Expanded(child: TextFormField(controller: priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: '가격을 적어주세요'),
                validator: (v) {
                  if (v == null || v.isEmpty) return '가격을 입력해 주세요';
                  if (int.tryParse(v) == null) return '숫자만 입력해 주세요';
                  return null;
                })),
            const SizedBox(width: 8),
            const Text('원')
          ]),
          const SizedBox(height: 12),
          const Text('상품 설명'),
          Expanded(child: TextFormField(controller: descriptionController, maxLines: null, expands: true, decoration: const InputDecoration(border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? '상품 설명을 입력해 주세요' : null)),
        ]),
      ),
    );
  }
}
