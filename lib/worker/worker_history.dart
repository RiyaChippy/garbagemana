import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Task> _completedTasks = [];
  String currentWorkerId = ''; // Assuming you have the current worker's ID

  @override
  void initState() {
    super.initState();
    _fetchCompletedTasks();
  }

  Future<void> _fetchCompletedTasks() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('history')
          .where('workerId', isEqualTo: currentWorkerId) // Filter by workerId
          .get();

      List<Task> completedTasks = querySnapshot.docs.map((doc) {
        return Task.fromFirestore(doc);
      }).toList();

      setState(() {
        _completedTasks = completedTasks;
      });
    } catch (error) {
      print('Error fetching completed tasks: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40), // To add some space at the top
          Text(
            'Collection History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 107, 100, 237),
            ),
          ),
          Expanded(
            child: _completedTasks.isEmpty
                ? Center(child: Text('No completed tasks found'))
                : ListView.builder(
                    itemCount: _completedTasks.length,
                    itemBuilder: (context, index) {
                      Task task = _completedTasks[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 179, 198, 252),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(task.name),
                          subtitle: Text(task.address),
                          trailing: Text(
                              'Location: ${task.location.latitude}, ${task.location.longitude}'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HistoryPage(),
  ));
}
