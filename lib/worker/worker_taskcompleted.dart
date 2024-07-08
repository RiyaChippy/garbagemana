import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskCountPage extends StatefulWidget {
  const TaskCountPage({Key? key}) : super(key: key);

  @override
  _TaskCountPageState createState() => _TaskCountPageState();
}

class _TaskCountPageState extends State<TaskCountPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int completedTasks = 0;
  String currentWorkerId =
      'workerDocumentID'; // Replace with actual worker document ID

  @override
  void initState() {
    super.initState();
    fetchCompletedTasks();
  }

  void fetchCompletedTasks() async {
    try {
      QuerySnapshot<Map<String, dynamic>> historySnapshot = await _firestore
          .collection('history')
          .where('workerId', isEqualTo: currentWorkerId) // Filter by workerId
          .get();

      setState(() {
        completedTasks = historySnapshot.size;
      });
    } catch (error) {
      print('Error fetching tasks from history: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate percentage of completed tasks compared to target
    double percentComplete = completedTasks / 10.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Count'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Completed Tasks: $completedTasks',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Circular progress indicator
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 15.0,
              percent: percentComplete > 1.0 ? 1.0 : percentComplete,
              center: Text(
                '${(percentComplete * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 20),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey[300]!,
              progressColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Task Count Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: TaskCountPage(),
    debugShowCheckedModeBanner: false, // Remove the debug banner
  ));
}
