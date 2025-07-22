import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _D();
}

class _D extends State<ProductDetailScreen> {
  late ProductModel p;
  int qty = 1;
  final Color brandRed = const Color(0xFFAD2426);

  String formatNumber(int x) => x.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]},',
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    p = ModalRoute.of(context)!.settings.arguments as ProductModel;
  }

  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(
          title: const Text('상품 상세'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 24),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildImage(p.imageUrl),
              const SizedBox(height: 12),
              Text(
                p.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${formatNumber(p.price)}원',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(p.description),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () =>
                        setState(() => qty = qty > 1 ? qty - 1 : 1),
                    icon: const Icon(Icons.remove),
                  ),
                  Text(formatNumber(qty),
                      style: const TextStyle(fontSize: 24)),
                  IconButton(
                    onPressed: () => setState(() => qty++),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '총 결제 금액: ${formatNumber(p.price * qty)}원',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandRed,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('${p.name}을(를) $qty개 구매하시겠습니까?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('취소'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // 알림창 닫기
                              Navigator.popUntil(context,
                                  (route) => route.settings.name == '/'); // 홈으로 이동
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    '구매하기',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildImage(String url) {
    if (url.startsWith('http')) {
      return Image.network(url, height: 200, fit: BoxFit.cover);
    } else {
      return Image.asset(url, height: 200, fit: BoxFit.cover);
    }
  }
}
