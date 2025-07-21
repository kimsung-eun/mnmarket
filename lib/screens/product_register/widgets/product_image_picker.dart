import 'package:flutter/material.dart';

class ProductImagePicker extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onBack;
  final ValueChanged<String> onImageSelected;

  const ProductImagePicker({
    super.key,
    required this.imageUrl,
    required this.onBack,
    required this.onImageSelected,
  });

  void _pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text('이미지 선택', textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              onImageSelected('https://picsum.photos/200/300');
              Navigator.pop(context);
            },
            child: const Text('선택'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          color: Colors.grey[300],
          width: double.infinity,
          child: imageUrl != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(imageUrl!, fit: BoxFit.cover),
                    const Center(
                      child: Text(
                        '이미지 선택됨',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(child: Text('상품 이미지')),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 28),
            onPressed: onBack,
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.small(
            onPressed: () => _pickImage(context),
            backgroundColor: Colors.white,
            child: const Icon(Icons.camera_alt, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
