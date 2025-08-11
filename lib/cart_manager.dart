import 'package:flutter/material.dart';

class CartItem {
  final Map<String, dynamic> product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  // Helper to calculate item subtotal
  double get subtotal => (product['price'] as double) * quantity;
}
  
class CartManager extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items =>
      List.unmodifiable(_items); // Prevent external modification
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.subtotal);
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  void addToCart(Map<String, dynamic> product) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product['id'] == product['id'], // Use unique ID if available
    );

    if (existingIndex != -1) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void increment(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrement(int index) {
    if (index >= 0 && index < _items.length && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Optional: Find item by product ID
  CartItem? findItemById(dynamic productId) {
    try {
      return _items.firstWhere((item) => item.product['id'] == productId);
    } catch (e) {
      return null;
    }
  }
}
