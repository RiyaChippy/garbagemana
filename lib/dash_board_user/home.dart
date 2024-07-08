import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:garbagemana/dash_board_user/Payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserHome(),
    );
  }
}

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final List<Map<String, dynamic>> wasteTypes = [
    {'name': 'Organic', 'icon': Icons.eco, 'amount per Kg': 2.0},
    {'name': 'Plastic', 'icon': Icons.local_drink, 'amount per Kg': 4.0},
    {'name': 'Paper', 'icon': Icons.description, 'amount per Kg': 2.0},
    {'name': 'Metal', 'icon': Icons.build, 'amount per Kg': 8.0},
    {'name': 'Glass', 'icon': Icons.wine_bar, 'amount per Kg': 10.0},
    {'name': 'E-waste', 'icon': Icons.devices, 'amount per Kg': 12.0},
  ];

  final List<Map<String, dynamic>> selectedWasteTypes = [];

  void _navigateToPaymentAndAddress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PaymentAndAddressScreen(selectedWasteTypes: selectedWasteTypes),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedWasteTypes.clear();
          selectedWasteTypes.addAll(value);
        });
      }
    });
  }

  void _addToSelected(Map<String, dynamic> wasteType) {
    setState(() {
      selectedWasteTypes.add({
        'name': wasteType['name'],
        'icon': wasteType['icon'],
        'amount':
            wasteType['amount per Kg'] ?? 0.0, // Ensure amount is not null here
      });
    });
    _navigateToPaymentAndAddress(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color:
                  const Color.fromARGB(255, 159, 154, 252), // Light blue color
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hello Name',
                          style: TextStyle(
                            fontSize: 28, // Increased font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 48), // Placeholder for symmetry
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Effective management of garbage is crucial for a sustainable environment. Let’s work together to keep our surroundings clean and green.',
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily:
                                'Bradley Hand ITC', // Changed font family
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color:
                    Color.fromRGBO(184, 181, 247, 1), // Grey background color
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: wasteTypes.length,
                    itemBuilder: (ctx, index) {
                      return WasteTypeCard(
                        name: wasteTypes[index]['name'],
                        icon: wasteTypes[index]['icon'],
                        amount: wasteTypes[index]['amount per Kg'] ??
                            0.0, // Ensure amount is not null here
                        onTap: () => _addToSelected(wasteTypes[index]),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToPaymentAndAddress(context),
        child: const Icon(Icons.payment),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class WasteTypeCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final double amount;
  final VoidCallback onTap;

  const WasteTypeCard({
    required this.name,
    required this.icon,
    required this.amount,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: const Color.fromARGB(
                      255, 107, 100, 237), // Changed icon color to blue
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Amount: ₹${amount.toStringAsFixed(2)}', // Ensure amount is not null here
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
