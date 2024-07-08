import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: const ContainerList(),
      ),
    );
  }
}

class ContainerList extends StatelessWidget {
  const ContainerList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white
          .withOpacity(0.8), // Adjust opacity for background image visibility
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Garbomanage App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 107, 100, 237),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Our app provides a convenient solution for waste management. Here are some features:',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(0.1),
              1: FlexColumnWidth(0.9),
            },
            children: [
              featureItem('1. Home Pickup Service',
                  'We offer home pickup services for your garbage, ensuring a hassle-free experience.'),
              featureItem('2. Affordable Pricing',
                  'Our charges are competitive and affordable for everyone.'),
              featureItem('3. Easy Scheduling',
                  'Schedule your pickups at your convenience with our easy-to-use app interface.'),
              featureItem('4. Eco-Friendly Disposal',
                  'We ensure that the waste is disposed of in an eco-friendly manner.'),
              featureItem('5. Real-time Tracking',
                  'Track the status of your pickup in real-time through the app.'),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  TableRow featureItem(String title, String description) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Icon(
            Icons.check_circle,
            color: const Color.fromARGB(255, 107, 100, 237),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 107, 100, 237),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
