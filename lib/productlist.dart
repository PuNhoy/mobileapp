// product_detail_page.dart
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final void Function(Map<String, dynamic> product, int quantity) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  //  double unitPrice = 100.0;

  bool get isFavorite => widget.product['isFavorite'] ?? false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFF3B2A26),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Right padding
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color:
                    isFavorite
                        ? const Color.fromARGB(255, 249, 48, 48)
                        : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  product['isFavorite'] = !isFavorite;
                });
              },
            ),
          ),
        ],
        elevation: 0,
      ),

      body: Column(
        children: [
          Image.asset(product['image'], height: 200),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${product['rating']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${product['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Total Price: \$${(quantity * (product['price'] as double)).toStringAsFixed(2)}',

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text("(13.6\" & 15.3\" — M4 Chip)"),
                  const SizedBox(height: 8),
                  // const Text(
                  //   "Powered by Apple’s M4 SoC: 10-core CPU (4 performance + 6 efficiency cores); GPU options: 8-core (13”) or 10-core (15”)",
                  //   style: TextStyle(fontSize: 13, color: Colors.grey),
                  // ),
                  const SizedBox(height: 16),
                  const Text(
                    "Add One",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  //  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: _buildAddOneItem('assets/images/msi1.png'),
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: _buildAddOneItem('assets/images/Dell1.png'),
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: _buildAddOneItem('assets/images/apple.png'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        widget.onAddToCart(widget.product, quantity);

                        showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: const Text("Added to Cart"),
                                content: Text(
                                  'You added $quantity item(s) of ${widget.product['name']}',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                        );
                      },

                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOneItem(String imagePath) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 90, // enlarged from 60
          height: 90, // enlarged from 60
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          bottom: 4,
          right: 4,
          child: CircleAvatar(
            radius: 12, // slightly larger
            backgroundColor: Colors.green,
            child: Icon(Icons.add, size: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
