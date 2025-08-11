import 'package:flutter/material.dart';
import 'package:my_app/dashboard_screen.dart';
import 'package:my_app/cart_manager.dart';

class SearchScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final void Function(Map<String, dynamic> product, int quantity) onAddToCart;

  const SearchScreen({
    super.key,
    required this.cartItems,
    required this.onAddToCart,
  });

  @override
  State<SearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/images/apple.png',
      'name': 'Macair Pro',
      'price': 999.00,
      'rating': 3.5,
    },
    {
      'image': 'assets/images/apple1.png',
      'name': 'Macair 13',
      'price': 1299.00,
      'rating': 4.5,
    },
    {
      'image': 'assets/images/msi1.png',
      'name': 'MSI Titan',
      'price': 4499.00,
      'rating': 4.2,
    },
    {
      'image': 'assets/images/msiraider.png',
      'name': 'MSI Raider',
      'price': 1499.00,
      'rating': 4.7,
    },
    {
      'image': 'assets/images/asusolet.png',
      'name': 'ASUS Olet',
      'price': 1200.00,
      'rating': 4.2,
    },
    {
      'image': 'assets/images/asus12.png',
      'name': 'ASUS Zephyrus',
      'price': 1200.00,
      'rating': 4.2,
    },
    {
      'image': 'assets/images/zenbook.png',
      'name': 'ASUS Zenbook',
      'price': 850.00,
      'rating': 4.7,
    },
    {
      'image': 'assets/images/acer.png',
      'name': 'ACER Nitro',
      'price': 899.00,
      'rating': 4.2,
    },
    {
      'image': 'assets/images/acernitro.png',
      'name': 'ACER Aspire',
      'price': 1499.00,
      'rating': 4.7,
    },
    {
      'image': 'assets/images/dell.png',
      'name': 'Dell XPS 13',
      'price': 899.00,
      'rating': 4.2,
    },
    {
      'image': 'assets/images/dell2.png',
      'name': 'Dell Inspiron',
      'price': 1499.00,
      'rating': 4.7,
    },
    {
      'image': 'assets/images/lenovo.png',
      'name': 'Lenovo ThinkPad',
      'price': 899.00,
      'rating': 4.2,
    },
    {
      'image': 'assets/images/legend.png',
      'name': 'Lenovo Legion',
      'price': 1499.00,
      'rating': 4.7,
    },
    {
      'image': 'assets/images/Airpods.png',
      'name': 'AirPods',
      'price': 899.00,
      'rating': 4.2,
    },
    {
      'image': 'assets/images/Airpodspro.png',
      'name': 'AirPods Pro',
      'price': 1499.00,
      'rating': 4.7,
    },
  ];

  String searchQuery = "";

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: product.containsKey('image')
                  ? Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                      height: 90,
                      width: double.infinity,
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              product['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product['price'].toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: product,
                            onAddToCart: widget.onAddToCart, // Use the callback from parent
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where(
          (p) => p['name'].toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search products...",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(filteredProducts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}