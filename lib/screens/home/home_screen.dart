import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'dog';
  final List<ProductModel> products = [];
  final List<bool> isLiked = [];
  final String imagePath = 'assets/images/sunny.jpeg';

  @override
  void initState() {
    super.initState();

    products.addAll([
      ProductModel(
        id: 1,
        name: '강아지 상품',
        price: 12000,
        imageUrl: imagePath,
        description: '기본 등록된 상품입니다.',
      ),
      ProductModel(
        id: 2,
        name: '강아지 상품',
        price: 12000,
        imageUrl: imagePath,
        description: '기본 등록된 상품입니다.',
      ),
    ]);

    // 하트 초기 상태도 함께 초기화
    isLiked.addAll(List.generate(products.length, (_) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('멍냥마켓')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 카테고리 선택 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton('강아지', selectedCategory == 'dog', () {
                  setState(() {
                    selectedCategory = 'dog';
                  });
                }),
                const SizedBox(width: 16),
                _buildCategoryButton('고양이', selectedCategory == 'cat', () {
                  if (selectedCategory == 'cat') return;
                  setState(() {
                    selectedCategory = 'cat';
                  });
                  Future.delayed(Duration.zero, () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('알림'),
                        content: const Text('등록된 상품이 없습니다.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                selectedCategory = 'dog';
                              });
                            },
                            child: const Text('닫기'),
                          ),
                        ],
                      ),
                    );
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '신규',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // 상품 목록
            Expanded(
              child: selectedCategory == 'cat'
                  ? const Center(child: Text('')) // 고양이 탭은 빈 화면
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) =>
                          _buildProductCard(products[index], index),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/register');
          if (result is ProductModel) {
            setState(() {
              products.add(result);
              isLiked.add(false); // 새 상품 추가 시 좋아요 상태도 추가
            });
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildCategoryButton(
    String label,
    bool isSelected,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.grey[300] : Colors.grey[200],
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _buildProductCard(ProductModel product, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // 상품명, 가격
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product.price.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              // 하트 버튼
              IconButton(
                icon: Icon(
                  isLiked[index] ? Icons.favorite : Icons.favorite_border,
                  color: isLiked[index] ? Colors.pink : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isLiked[index] = !isLiked[index];
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
