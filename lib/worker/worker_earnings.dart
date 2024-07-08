import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({Key? key}) : super(key: key);

  @override
  _EarningsPageState createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double totalDeliveryBonus = 0.0; // Initialize with 0 bonus
  final double baseWage = 500.0; // Set the base wage to 500
  final double targetAmount = 1000.0; // Set the target amount to 1000
  String currentWorkerId =
      'workerDocumentID'; // Replace with actual worker document ID

  @override
  void initState() {
    super.initState();
    fetchTotalDeliveryBonus();
  }

  void fetchTotalDeliveryBonus() async {
    try {
      QuerySnapshot historySnapshot = await _firestore
          .collection('history')
          .where('workerId', isEqualTo: currentWorkerId) // Filter by workerId
          .get();

      double total = 0.0;

      for (var doc in historySnapshot.docs) {
        List<dynamic> wasteTypes = doc['wasteTypes'];
        for (var wasteType in wasteTypes) {
          double amount = wasteType['amount'] ?? 0.0;
          total += amount * 0.30; // Calculate 30% of each amount
        }
      }

      setState(() {
        totalDeliveryBonus = total;
      });

      // Update the worker's earnings in the Firebase collection
      updateEarnings(totalDeliveryBonus);
    } catch (error) {
      print('Error fetching delivery bonus: $error');
      // Handle error as needed
    }
  }

  void updateEarnings(double totalDeliveryBonus) async {
    try {
      // Calculate the total earnings
      double totalEarnings = baseWage + totalDeliveryBonus;

      // Update the earnings in the worker's document
      await _firestore.collection('earnings').doc(currentWorkerId).set({
        'totalDeliveryBonus': totalDeliveryBonus,
        'baseWage': baseWage,
        'totalEarnings': totalEarnings,
      });
    } catch (error) {
      print('Error updating earnings: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalEarnings =
        baseWage + totalDeliveryBonus; // Calculate total earnings
    double completedProportion = totalEarnings /
        targetAmount; // Calculate the proportion of completed earnings
    double remainingProportion = 1 - completedProportion;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Earnings',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: SemiPieChartPainter(
                  completedProportion: completedProportion,
                  remainingProportion: remainingProportion,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Delivery Bonus: ₹${totalDeliveryBonus.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Base Wage: ₹${baseWage.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Total Earnings: ₹${totalEarnings.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class SemiPieChartPainter extends CustomPainter {
  final double completedProportion;
  final double remainingProportion;
  final Color completedColor;
  final Color remainingColor;

  SemiPieChartPainter({
    required this.completedProportion,
    required this.remainingProportion,
    this.completedColor = const Color.fromARGB(255, 114, 33, 243),
    this.remainingColor = const Color.fromARGB(255, 234, 214, 250),
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height);

    // Draw completed segment
    _drawSegment(
        canvas, center, radius, 0, completedProportion * pi, completedColor);

    // Draw remaining segment
    _drawSegment(
        canvas, center, radius, completedProportion * pi, pi, remainingColor);
  }

  void _drawSegment(Canvas canvas, Offset center, double radius,
      double startAngle, double sweepAngle, Color color) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = radius
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -startAngle,
      -sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Earnings Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: EarningsPage(),
    debugShowCheckedModeBanner: false, // Disable debug banner
  ));
}
