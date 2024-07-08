import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garbagemana/admin/addworker.dart';
import 'package:garbagemana/admin/admincontroll.dart';

class WorkerPage extends StatefulWidget {
  @override
  _WorkerPageState createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  final Workers _workers =
      Workers(); // Assuming Workers class handles data fetching

  List<Map<String, dynamic>> _workersList = [];

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  void _loadWorkers() async {
    List<Map<String, dynamic>> workers = await _workers.getWorkers();
    setState(() {
      _workersList = workers;
    });
  }

  void _addWorker(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddWorkerPage()),
    ).then((_) {
      _loadWorkers();
    });
  }

  void _showWorkerDetails(BuildContext context, Map<String, dynamic> worker) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(worker['name']),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Email: ${worker['email']}'),
                Text('Phone Number: ${worker['phoneNumber']}'),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateWorker(BuildContext context, Map<String, dynamic> worker) {
    // Implement worker update logic here
  }

  void _deleteWorker(BuildContext context, Map<String, dynamic> worker) {
    // Implement worker delete logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Workers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 107, 100, 237),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _workersList.length,
                  itemBuilder: (context, index) {
                    final worker = _workersList[index];
                    return GestureDetector(
                      onTap: () => _showWorkerDetails(context, worker),
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(worker['name']),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            width: 450,
            height: 300,
            bottom: 40,
            left: 5,
            child: Container(
              width: 720, // Set a specific width for the container
              height: 500, // Set a specific height for the container
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/worker.gif'),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addWorker(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
