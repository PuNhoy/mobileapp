import 'package:flutter/material.dart';
import 'package:my_app/cart_manager.dart';
import 'package:my_app/check_out.dart';

class ShopCartScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final VoidCallback? onBackPressed;
  final Function(int index)? onRemoveItem;
  final Function(int index)? onIncrementQuantity;
  final Function(int index)? onDecrementQuantity;

  const ShopCartScreen({
    super.key,
    required this.cartItems,
    this.onBackPressed,
    this.onRemoveItem,
    this.onIncrementQuantity,
    this.onDecrementQuantity,
  });

  @override
  State<ShopCartScreen> createState() => _ShopCartScreenState();
}

class _ShopCartScreenState extends State<ShopCartScreen> {
  void _incrementQuantity(int index) {
    // Call the parent callback to update the main cart
    widget.onIncrementQuantity?.call(index);
    // Update local state for immediate UI feedback
    setState(() {});
  }

  void _decrementQuantity(int index) {
    // Call the parent callback to update the main cart
    widget.onDecrementQuantity?.call(index);
    // Update local state for immediate UI feedback
    setState(() {});
  }

  void _removeFromCart(int index) {
    // Call the parent callback to update the main cart
    widget.onRemoveItem?.call(index);
    // Update local state for immediate UI feedback
    setState(() {});
  }

  double get _totalPrice {
    return widget.cartItems.fold(
      0.0,
      (sum, item) => sum + (item.product['price'] * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E2E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E2E2C),
        title: const Text('Cart', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Use the callback to go back to home tab instead of Navigator.pop
            if (widget.onBackPressed != null) {
              widget.onBackPressed!();
            } else {
              // Fallback: try to pop if callback is not provided
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }
          },
        ),
      ),
      body:
          widget.cartItems.isEmpty
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.white54,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(color: Colors.white54, fontSize: 18),
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.product['image'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                            title: Text(
                              item.product['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$${item.product['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed:
                                          () => _decrementQuantity(index),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '${item.quantity}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.green,
                                      ),
                                      onPressed:
                                          () => _incrementQuantity(index),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Subtotal: \$${(item.product['price'] * item.quantity).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Remove Item'),
                                      content: Text(
                                        'Are you sure you want to remove ${item.product['name']} from your cart?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _removeFromCart(index);
                                          },
                                          child: const Text(
                                            'Remove',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E1E1C),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Items:',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${widget.cartItems.fold(0, (sum, item) => sum + item.quantity)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Price:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${_totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                widget.cartItems.isEmpty
                                    ? null
                                    : () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Checkout'),
                                            content: Text(
                                              'Proceed to checkout with ${widget.cartItems.length} items?\nTotal: \$${_totalPrice.toStringAsFixed(2)}',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed:
                                                    () =>
                                                        Navigator.pop(context),
                                                child: const Text('Cancel'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (
                                                            context,
                                                          ) => CheckoutPaymentScreen(
                                                            cartItems:
                                                                widget
                                                                    .cartItems,
                                                            totalAmount:
                                                                _totalPrice,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: const Text('Checkout'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              disabledBackgroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              widget.cartItems.isEmpty
                                  ? 'Cart is Empty'
                                  : 'Checkout',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
