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
  final String imagePath2 = 'assets/images/cat_toy.png';
  final Color brandRed = const Color(0xFFAD2426);

  @override
  void initState() {
    super.initState();

    products.addAll([
      ProductModel(
        id: 1,
        name: '강아지 상품',
        price: 12000,
        imageUrl: imagePath,
        description: '강아지 상품입니다.',
        category: 'dog',
      ),
      ProductModel(
        id: 2,
        name: '고양이 상품',
        price: 13000,
        imageUrl: imagePath2,
        description: '고양이 상품입니다.',
        category: 'cat',
      ),
    ]);

    isLiked.addAll(List.generate(products.length, (_) => false));
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .asMap()
        .entries
        .where((entry) => entry.value.category == selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: brandRed,
        title: const Text(
          '멍냥마켓',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
                  setState(() {
                    selectedCategory = 'cat';
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
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(child: Text('등록된 상품이 없습니다.'))
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index].value;
                        final realIndex = products.indexOf(product);
                        return _buildProductCard(product, realIndex);
                      },
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
              products.insert(0, result); // 새 상품을 맨 앞에
              isLiked.insert(0, false);
            });
          }
        },
        backgroundColor: brandRed,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryButton(
      String label, bool isSelected, VoidCallback onPressed) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: product.imageUrl.startsWith('http')
                    ? Image.network(
                        product.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      )
                    : Image.asset(
                        product.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.grey[700],
                    onPressed: () {
                      setState(() {
                        products.removeAt(index);
                        isLiked.removeAt(index);
                      });
                    },
                  ),
                  const SizedBox(height: 4),
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
            ],
          ),
        ),
      ),
    );
  }
}
