import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garbagemana/admin/admin_dashborad.dart';
import 'package:garbagemana/worker/worker_dashboard.dart';

class AdminAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInAdmin(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (userSnapshot.exists && userSnapshot.get('isAdmin') == true) {
          // Redirect to admin dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => addash()),
          );
        } else {
          // Show error message or redirect to user page
          print('User is not an admin');
          _auth.signOut(); // Sign out the user if they are not an admin
        }
      }
    } catch (e) {
      print('Failed to sign in: $e');
    }
  }

  Future<void> signInWorker(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (userSnapshot.exists && userSnapshot.get('isWorker') == true) {
          // Redirect to worker dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WorkerDashboard()),
          );
        } else {
          // Show error message or redirect to user page
          print('User is not a worker');
          _auth.signOut(); // Sign out the user if they are not a worker
        }
      }
    } catch (e) {
      print('Failed to sign in: $e');
    }
  }

  void _updateWorkerStatus(BuildContext context, String documentId,
      bool isWorker, Map<String, dynamic> data) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({'isWorker': isWorker}).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Worker status updated!')),
      );

      // Add or remove user from the "works" collection
      if (isWorker) {
        // If user is marked as a worker, add them to the "works" collection
        FirebaseFirestore.instance
            .collection('workers')
            .doc(documentId)
            .set(data);
      } else {
        // If user is not a worker, remove them from the "works" collection
        FirebaseFirestore.instance
            .collection('workers')
            .doc(documentId)
            .delete();
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update worker status: $error')),
      );
    });
  }
}
