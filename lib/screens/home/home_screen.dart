import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: products.isEmpty
          ? const Center(child: Text('등록된 상품이 없습니다.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (_, i) {
                final p = products[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.network(p.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                    title: Text(p.name),
                    subtitle: Text('${p.price}원'),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: p,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final p = await Navigator.pushNamed(context, '/register') as ProductModel?;
          if (p != null) setState(() => products.add(p));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
