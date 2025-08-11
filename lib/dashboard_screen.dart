import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Category/accessory_screen.dart';
import 'package:my_app/Category/acer_screen.dart';
import 'package:my_app/Category/allpage_screen.dart';
import 'package:my_app/Category/apple_screen.dart';
import 'package:my_app/Category/asus_screen.dart';
import 'package:my_app/Category/dell_screen.dart';
import 'package:my_app/Category/hp_screen.dart';
import 'package:my_app/Category/lenovo_screen.dart';
import 'package:my_app/Category/msi_screen.dart';
import 'package:my_app/app_colors.dart';
import 'package:my_app/cart_manager.dart' show CartItem;
// ignore: library_prefixes, unused_import, no_leading_underscores_for_library_prefixes
import 'package:my_app/dashboard_screen.dart' as _bannerController;
// ignore: unused_import
import 'package:my_app/productlist.dart';
import 'package:my_app/profile_screen.dart';
import 'package:my_app/search_screen.dart';
import 'package:my_app/shop_cart_screen.dart' show ShopCartScreen;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _bannerController = PageController();
  int _currentCategoryIndex = 0;
  int _selectedTabIndex = 0;
  Timer? _bannerTimer;
  final List<CartItem> _cartItems = [];

  int get _totalCartQuantity {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Method to add items to cart
  void _addToCart(Map<String, dynamic> product, int quantity) {
    setState(() {
      // Check if item already exists in cart
      int existingIndex = _cartItems.indexWhere(
        (item) => item.product['name'] == product['name'],
      );

      if (existingIndex >= 0) {
        // If item exists, update quantity
        _cartItems[existingIndex] = CartItem(
          product: _cartItems[existingIndex].product,
          quantity: _cartItems[existingIndex].quantity + quantity,
        );
      } else {
        // If item doesn't exist, add new item
        _cartItems.add(CartItem(product: product, quantity: quantity));
      }
    });
  }

  final List<String> categories = [
    'All',
    'Accessories',
    'ASUS',
    'MSI',
    'ACER',
    'HP',
    'Lenovo',
    'Apple',
    'Dell',
  ];

  // Function to filter products by category
  List<Map<String, dynamic>> _getFilteredProducts(String category) {
    if (category == 'All') {
      return products;
    }

    return products.where((product) {
      String productName = product['name'].toString().toLowerCase();
      String categoryLower = category.toLowerCase();

      switch (categoryLower) {
        case 'accessories':
          return productName.contains('accessories');
        case 'acer':
          return productName.contains('acer');
        case 'asus':
          return productName.contains('asus');
        case 'msi':
          return productName.contains('msi');
        case 'apple':
          return productName.contains('mackir'); // Based on your product names
        case 'dell':
          return productName.contains('dell');
        case 'lenovo':
          return productName.contains('lenovo');
        case 'hp':
          return productName.contains('hp');
        default:
          return false;
      }
    }).toList();
  }

  // Function to get the appropriate page widget based on category
  Widget _getCategoryPage(String category) {
    List<Map<String, dynamic>> filteredProducts = _getFilteredProducts(
      category,
    );

    switch (category) {
      case 'All':
        return AllpageScreen();
      case 'Accessories':
        return AccessoryScreen(products: filteredProducts);
      case 'ASUS':
        return AsusScreen(products: filteredProducts, onAddToCart: _addToCart);
      case 'MSI':
        return MsiScreen(products: filteredProducts, onAddToCart: _addToCart);
      case 'ACER':
        return AcerScreen(products: filteredProducts, onAddToCart: _addToCart);
      case 'HP':
        return HpScreen(products: filteredProducts, onAddToCart: _addToCart);
      case 'Lenovo':
        return LenovoScreen(
          products: filteredProducts,
          onAddToCart: _addToCart,
        );
      case 'Apple':
        return AppleScreen(products: filteredProducts, onAddToCart: _addToCart);
      case 'Dell':
        return DellScreen(products: filteredProducts, onAddToCart: _addToCart);
      default:
        return AllpageScreen();
    }
  }

  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/images/apple.png',
      'name': 'Apple Mac Pro',
      'price': 999.00,
      'rating': 3.5,
    },
    {
      'image': 'assets/images/apple1.png',
      'name': ' Apple Macair 13',
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

  final List<String> banners = [
    'assets/images/asus.jpg',
    'assets/images/msi.jpg',
    'assets/images/Acer.jpg',
    'assets/images/dell.jpg',
  ];
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // Dynamic AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child:
            _selectedTabIndex == 0 || _selectedTabIndex == 2
                ? AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.blue,
                  elevation: 0,
                  toolbarHeight: 80,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                'assets/images/profile.jpg',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Hello, Jun',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'View Profile >',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              child: const Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                            ),
                            const Positioned(
                              right: 6,
                              top: 6,
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                : AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        _selectedTabIndex = 0; // Go back to Home tab
                      });
                    },
                  ),
                ),
      ),

      body: _buildBodyContent(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (_totalCartQuantity > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$_totalCartQuantity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Shop',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return SearchScreen(cartItems: _cartItems, onAddToCart: _addToCart);
      case 2:
        return ShopCartScreen(
          cartItems: _cartItems,
          onBackPressed: () {
            setState(() {
              _selectedTabIndex = 0; // Go back to Home tab
            });
          },
          onRemoveItem: (index) {
            setState(() {
              _cartItems.removeAt(index);
            });
          },
          onIncrementQuantity: (index) {
            setState(() {
              _cartItems[index].quantity++;
            });
          },
          onDecrementQuantity: (index) {
            setState(() {
              if (_cartItems[index].quantity > 1) {
                _cartItems[index].quantity--;
              }
            });
          },
        );
      case 3:
        return const ProfileScreen();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildBannerSlider(), // Now uses CarouselSlider
          const SizedBox(height: 16),
          const SizedBox(height: 24),
          _buildCategoriesHeader(),
          const SizedBox(height: 12),
          _buildCategoriesList(),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => _buildProductCard(products[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 170,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        viewportFraction: 0.95,
        onPageChanged: (index, reason) {
          setState(() {
            _bannerController.jumpToPage(index);
          });
        },
      ),
      items:
          banners.map((bannerPath) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                bannerPath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
    );
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _bannerTimer?.cancel();
    super.dispose();
  }

  Widget _buildCategoriesHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('See All'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _currentCategoryIndex == index;

          return ChoiceChip(
            label: Text(
              categories[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: isSelected,
            selectedColor: Colors.blue,
            backgroundColor: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _currentCategoryIndex = index;
                });

                // Navigate to the selected category page and wait for result
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _getCategoryPage(categories[index]),
                  ),
                ).then((_) {
                  // When returning from category page, reset to "All" category
                  setState(() {
                    _currentCategoryIndex = 0; // Reset to "All" (index 0)
                  });
                });
              }
            },
          );
        },
      ),
    );
  }

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
              child:
                  product.containsKey('image')
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
                          builder:
                              (context) => ProductDetailPage(
                                product: product,
                                onAddToCart:
                                    _addToCart, // Pass the callback function
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
}

// ProductDetailPage class (you can keep this in a separate file)
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
            padding: const EdgeInsets.only(right: 16.0),
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
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(
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
                  const SizedBox(height: 16),
                  const Text(
                    "Add One",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                        // Call the callback to add item to cart
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
                                    onPressed: () {
                                      Navigator.pop(context); // Close dialog
                                      Navigator.pop(
                                        context,
                                      ); // Go back to dashboard
                                    },
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
          width: 90,
          height: 90,
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
            radius: 12,
            backgroundColor: Colors.green,
            child: Icon(Icons.add, size: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
