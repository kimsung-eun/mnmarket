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
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ✅ 이미지 표시 (asset 또는 network 자동 구분)
          _buildImage(p.imageUrl),
          const SizedBox(height: 12),
          Text(
            p.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                onPressed: () => setState(() => qty = qty > 1 ? qty - 1 : 1),
                icon: const Icon(Icons.remove),
              ),
              Text(formatNumber(qty), style: const TextStyle(fontSize: 24)),
              IconButton(
                onPressed: () => setState(() => qty++),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
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
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('구매 완료'),
                              content: Text(
                                '${p.name} $qty개 구매 완료 (${formatNumber(qty * p.price)}원)',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('확인'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('구매하기'),
            ),
          ),
        ],
      ),
    ),
  );

  // ✅ 이미지 타입 구분 함수
  Widget _buildImage(String url) {
    if (url.startsWith('http')) {
      return Image.network(url, height: 200, fit: BoxFit.cover);
    } else {
      return Image.asset(url, height: 200, fit: BoxFit.cover);
    }
  }
}
