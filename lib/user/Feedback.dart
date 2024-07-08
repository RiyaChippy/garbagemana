// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedOption = 'Bad';
  double _rating = 1.0;

  void _submitFeedback() async {
    if (_formKey.currentState?.validate() ?? false) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'feedbackOption': _selectedOption,
            'rating': _rating,
          }, SetOptions(merge: true));

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feedback submitted successfully')),
          );
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit feedback: $error')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user is signed in')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 107, 100, 237),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Select an option:',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cursive',
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildRadioOption('Bad', 1.0),
                          _buildRadioOption('Average', 3.0),
                          _buildRadioOption('Good', 5.0),
                          const SizedBox(height: 20),
                          const Text(
                            'Rate the app:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Slider(
                            value: _rating,
                            min: 1,
                            max: 5,
                            divisions: 4,
                            label: _rating.toString(),
                            onChanged: (value) {
                              setState(() {
                                _rating = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submitFeedback,
                            child: const Text('Submit Feedback'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, double rating) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Radio<String>(
        value: label,
        groupValue: _selectedOption,
        onChanged: (value) {
          setState(() {
            _selectedOption = value!;
            _rating = rating;
          });
        },
      ),
    );
  }
}
