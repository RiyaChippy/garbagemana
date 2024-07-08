import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_details.dart';
import 'task_model.dart' as task_model; // Alias for task_model.dart
import 'worker_history.dart'; // Import the HistoryPage

class ViewTaskPage extends StatefulWidget {
  const ViewTaskPage({Key? key}) : super(key: key);

  @override
  _ViewTaskPageState createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<task_model.Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('tasks').get();
      List<task_model.Task> tasks = querySnapshot.docs.map((doc) {
        return task_model.Task.fromFirestore(doc);
      }).toList();

      setState(() {
        _tasks = tasks;
      });
    } catch (error) {
      print('Error fetching tasks: $error');
    }
  }

  void _moveToHistory(task_model.Task task) async {
    try {
      // Add task to history collection
      await _firestore.collection('history').doc(task.taskId).set(task.toMap());

      // Remove task from tasks collection
      await _firestore.collection('tasks').doc(task.taskId).delete();

      setState(() {
        _tasks.remove(task);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task marked as completed and moved to history'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (error) {
      print('Error moving task to history: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: const Color.fromARGB(255, 107, 100, 237),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TASK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.history, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? Center(child: Text('No tasks found'))
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      task_model.Task task = _tasks[index];
                      return ListTile(
                        title: Text(task.name),
                        subtitle: Text(task.address),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsPage(task: task),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            _moveToHistory(task);
                          },
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
    home: ViewTaskPage(),
  ));
}
