import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user with email and password
  Future<User?> registerWithEmailAndPassword(
    String name,
    String phoneNumber,
    String email,
    String address,
    String state,
    String pinCode,
    String password,
  ) async {
    try {
      // Create a new user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      // If user creation is successful, save additional user info in Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'address': address,
          'state': state,
          'pinCode': pinCode,
          'role': 'user',
          'createdAt':
              FieldValue.serverTimestamp(), // Optional: track creation time
        });
      }

      return user;
    } catch (e) {
      // Log and handle different types of exceptions
      if (e is FirebaseAuthException) {
        // Handle FirebaseAuth specific exceptions
        print('FirebaseAuthException: ${e.message}');
      } else if (e is FirebaseException) {
        // Handle Firestore specific exceptions
        print('FirebaseException: ${e.message}');
      } else {
        // Handle generic exceptions
        print('Exception: $e');
      }

      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').doc(uid).update(userData);
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  // Register a new worker with email and password
  Future<User?> registerWorkerWithEmailAndPassword(
    String name,
    String phoneNumber,
    String email,
    String address,
    String state,
    String pinCode,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        await _firestore.collection('workers').doc(user.uid).set({
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'address': address,
          'state': state,
          'pinCode': pinCode,
          'role': 'worker',
        });
      }
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Sign in a user with email and password
  Future<User?> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return user;
        } else {
          print("User document not found in Firestore.");
          return null;
        }
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Sign in a worker with email and password
  Future<User?> signInWorkerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        DocumentSnapshot workerDoc =
            await _firestore.collection('workers').doc(user.uid).get();
        if (workerDoc.exists) {
          return user;
        } else {
          print("Worker document not found in Firestore.");
          return null;
        }
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error);
    }
  }

  // Stream of authentication state changes
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}
