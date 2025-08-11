import 'package:flutter/material.dart';
import 'package:my_app/cart_manager.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalAmount;

  const CheckoutPaymentScreen({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  String selectedPaymentMethod = 'Credit Card';

  final _formKey = GlobalKey<FormState>();

  // Controllers for payment details
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  final List<String> creditcard = [
    'assets/images/visacard.jpg',
    'assets/images/master.jpg',
  ];

  bool isProcessingPayment = false;

  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      setState(() => isProcessingPayment = true);

      // Simulate payment processing delay
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isProcessingPayment = false);
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Payment Successful'),
                content: Text(
                  'Thank you for your payment of \$${widget.totalAmount.toStringAsFixed(2)}!',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // Go back to previous screen
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      });
    }
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardExpiryController.dispose();
    cardCvvController.dispose();
    super.dispose();
  }

  Widget _buildCartSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...widget.cartItems.map((item) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.product['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              title: Text(item.product['name']),
              subtitle: Text(
                'Qty: ${item.quantity} × \$${item.product['price'].toStringAsFixed(2)}',
              ),
              trailing: Text(
                '\$${(item.quantity * item.product['price']).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          );
        }),
        const Divider(),
        ListTile(
          title: const Text(
            'Total Items:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          trailing: Text(
            '${widget.cartItems.fold(0, (sum, item) => sum + item.quantity)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        ListTile(
          title: const Text(
            'Total Amount:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          trailing: Text(
            '\$${widget.totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RadioListTile<String>(
          title: const Text('Credit Card'),
          value: 'Credit Card',
          groupValue: selectedPaymentMethod,
          onChanged: (value) => setState(() => selectedPaymentMethod = value!),
        ),
        RadioListTile<String>(
          title: const Text('ABA'),
          value: 'ABA',
          groupValue: selectedPaymentMethod,
          onChanged: (value) => setState(() => selectedPaymentMethod = value!),
        ),
        RadioListTile<String>(
          title: const Text('ACLEDA'),
          value: 'ACLEDA',
          groupValue: selectedPaymentMethod,
          onChanged: (value) => setState(() => selectedPaymentMethod = value!),
        ),
        RadioListTile<String>(
          title: const Text('Cash on Delivery'),
          value: 'Cash on Delivery',
          groupValue: selectedPaymentMethod,
          onChanged: (value) => setState(() => selectedPaymentMethod = value!),
        ),
      ],
    );
  }

  // Widget _buildCreditCardForm() {
  //   if (selectedPaymentMethod != 'Credit Card') return const SizedBox.shrink();

  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       children: [
  //         TextFormField(
  //           controller: cardNumberController,
  //           keyboardType: TextInputType.number,
  //           decoration: const InputDecoration(
  //             labelText: 'Card Number',
  //             hintText: '1234 5678 9012 3456',
  //             border: OutlineInputBorder(),
  //           ),
  //           maxLength: 19,
  //           validator: (value) {
  //             if (value == null || value.isEmpty) {
  //               return 'Please enter card number';
  //             }
  //             if (value.replaceAll(' ', '').length < 16) {
  //               return 'Enter a valid card number';
  //             }
  //             return null;
  //           },
  //         ),
  //         const SizedBox(height: 10),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: TextFormField(
  //                 controller: cardExpiryController,
  //                 keyboardType: TextInputType.number,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Expiry Date',
  //                   hintText: 'MM/YY',
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 maxLength: 5,
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Enter expiry date';
  //                   }
  //                   // Simple regex for MM/YY format
  //                   if (!RegExp(
  //                     r'^(0[1-9]|1[0-2])\/?([0-9]{2})$',
  //                   ).hasMatch(value)) {
  //                     return 'Invalid expiry date';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //             const SizedBox(width: 10),
  //             Expanded(
  //               child: TextFormField(
  //                 controller: cardCvvController,
  //                 keyboardType: TextInputType.number,
  //                 decoration: const InputDecoration(
  //                   labelText: 'CVV',
  //                   hintText: '123',
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 maxLength: 3,
  //                 obscureText: true,
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Enter CVV';
  //                   }
  //                   if (value.length != 3) {
  //                     return 'CVV must be 3 digits';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isProcessingPayment ? null : _submitPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:
            isProcessingPayment
                ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : const Text(
                  'Confirm Payment',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E2E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E2E2C),
        title: const Text(
          'Checkout Payment',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildCartSummary(),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildPaymentMethodSelector(),
            ),
            const SizedBox(height: 10),
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: _buildCreditCardForm(),
            // ),
            const SizedBox(height: 20),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }
}
