import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFeedback extends StatefulWidget {
  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _feedbackData = [];

  @override
  void initState() {
    super.initState();
    _fetchFeedbackOptions();
  }

  Future<void> _fetchFeedbackOptions() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<Map> feedbackData = querySnapshot.docs
          .map((doc) {
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

            if (data != null &&
                data.containsKey('feedbackOption') &&
                data.containsKey('name')) {
              return {
                'feedbackOption': data['feedbackOption'] as String,
                'username': data['name'] as String,
              };
            }
            return {}; // Return an empty map if data is incomplete or missing
          })
          .where((feedback) => feedback.isNotEmpty)
          .toList(); // Filter out empty maps

      setState(() {
        _feedbackData = List<Map<String, dynamic>>.from(
            feedbackData); // Ensure type conversion
      });
    } catch (error) {
      print('Error fetching feedback options: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User Feedback',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _feedbackData.isEmpty
                ? Text(
                    'No feedback available',
                    style: TextStyle(fontSize: 24),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _feedbackData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 165, 201, 225),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(
                              'Username: ${_feedbackData[index]['username']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Feedback Option: ${_feedbackData[index]['feedbackOption']}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserFeedback(),
  ));
}
