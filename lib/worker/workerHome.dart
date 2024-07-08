import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ViewTask.dart';

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({Key? key}) : super(key: key);

  @override
  _WorkerHomePageState createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:
            Colors.grey.shade300, // Grey background color for the whole screen
        child: Center(
          child: StreamBuilder<DocumentSnapshot>(
            stream: _firestore.collection('workers').doc(user?.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Text('No data found');
              }

              final workerData = snapshot.data?.data() as Map<String, dynamic>?;

              if (workerData == null) {
                return Text('No data found');
              }

              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 131, 135, 255),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 214, 213, 213).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome, ${workerData['name']}!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email: ${workerData['email']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone Number: ${workerData['phoneNumber']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Address: ${workerData['address']}, ${workerData['state']} ${workerData['pinCode']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewTaskPage()),
                        );
                      },
                      child: Text('View Tasks'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
