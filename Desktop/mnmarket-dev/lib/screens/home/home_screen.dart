import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'dog'; // 기본 강아지 탭
  final List<bool> isLiked = [false, false]; // 하트 상태
  final String imagePath = 'assets/images/sunny.jpeg'; // 상품 이미지 경로

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('멍냥마켓')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ✅ 강아지/고양이 버튼
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

            // ✅ 상품 목록
            Expanded(
              child: selectedCategory == 'cat'
                  ? const Center(child: Text('')) // 고양이 탭은 빈 화면
                  : ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) => _buildProductCard(index),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // 등록 버튼 등 추가 가능
        child: const Icon(Icons.edit),
      ),
    );
  }

  // ✅ 카테고리 버튼 위젯
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

  // ✅ 상품 카드 위젯
  Widget _buildProductCard(int index) {
    return Card(
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
                imagePath,
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
                children: const [
                  Text(
                    '강아지 상품',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '12,000원',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // 하트
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
    );
  }
}
