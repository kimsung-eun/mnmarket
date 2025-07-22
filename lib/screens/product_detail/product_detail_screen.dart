import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
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
  Widget build(BuildContext context) {
    final total = p.price * qty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '상품 상세',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // 이미지 영역
          Flexible(
            flex: 5,
            child: p.imageUrl.startsWith('http')
                ? Image.network(p.imageUrl, width: double.infinity, fit: BoxFit.contain)
                : Image.asset(p.imageUrl, width: double.infinity, fit: BoxFit.contain),
          ),

          // 상세 정보
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('${formatNumber(p.price)}원', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 12),
                  Expanded(child: SingleChildScrollView(child: Text(p.description))),
                ],
              ),
            ),
          ),
        ],
      ),

      // 구매 버튼 및 수량 하단 고정
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 수량 조절 및 총 금액
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => setState(() => qty = qty > 1 ? qty - 1 : 1),
                          icon: const Icon(Icons.remove),
                        ),
                        Text('$qty', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () => setState(() => qty++),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    Text(
                      '총 결제금액: ${formatNumber(total)}원',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // 구매 버튼
              SizedBox(
                width: 140,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('${p.name} ${qty}개 구매하시겠습니까?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('구매하기', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
