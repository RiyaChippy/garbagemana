import 'package:flutter/material.dart';
import 'package:garbagemana/user/user_dashboard.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
  final double finalAmount; // Total amount to be paid
  final String userName; // User's name
  final List<Map<String, dynamic>> selectedWasteTypes; // Selected waste types
  final DateTime paymentDateTime; // Date and time of payment

  const PaymentPage({
    required this.finalAmount,
    required this.userName,
    required this.selectedWasteTypes,
    required this.paymentDateTime,
    Key? key,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Payment Method'),
        backgroundColor: const Color.fromARGB(255, 107, 100, 237),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            ListTile(
              title: const Text('Debit Card'),
              leading: Radio<String>(
                value: 'Debit Card',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Credit Card'),
              leading: Radio<String>(
                value: 'Credit Card',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Net Banking'),
              leading: Radio<String>(
                value: 'Net Banking',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('UPI Payment'),
              leading: Radio<String>(
                value: 'UPI Payment',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to payment successful screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessfulPage(
                      finalAmount: widget.finalAmount,
                      userName: widget.userName,
                      selectedWasteTypes: widget.selectedWasteTypes,
                      paymentMethod: _selectedPaymentMethod,
                      paymentDateTime: widget.paymentDateTime,
                    ),
                  ),
                );
              },
              child: const Text('Proceed to Pay'),
            ),
            const SizedBox(height: 20),
            Positioned(
                width: 180, // Set a specific width for the container
                height: 200,
                top: 40,
                left: 10,
                child: Container(
                  width: 220, // Set a specific width for the container
                  height: 300, // Set a specific height for the container
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/welcome.png'),
                    ),
                  ),
                )) // Payment illustration
          ],
        ),
      ),
    );
  }
}
// for date formatting

class PaymentSuccessfulPage extends StatelessWidget {
  final double finalAmount; // Total amount paid
  final String userName; // User's name
  final List<Map<String, dynamic>> selectedWasteTypes; // Selected waste types
  final String paymentMethod; // Selected payment method
  final DateTime paymentDateTime; // Date and time of payment

  const PaymentSuccessfulPage({
    required this.finalAmount,
    required this.userName,
    required this.selectedWasteTypes,
    required this.paymentMethod,
    required this.paymentDateTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Successful'),
        backgroundColor: const Color.fromARGB(255, 107, 100, 237),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 80, color: Colors.green),
                const SizedBox(height: 20),
                const Text(
                  'Payment Successful!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Display receipt information
                const SizedBox(height: 8),
                Text('Payment Method: $paymentMethod'),
                const SizedBox(height: 8),
                Text('Payment Amount: ₹${finalAmount.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                Text(
                    'Payment Date & Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(paymentDateTime)}'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  },
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
