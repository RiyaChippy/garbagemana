import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updatePaymentStatusAndMoveDetails() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      if (userData != null && userData['session'] == true) {
        // Move user details to tasks collection
        await _firestore.collection('tasks').doc(user.uid).set(userData);

        // Optionally, you can delete the user data from the users collection after moving
        // await _firestore.collection('users').doc(user.uid).delete();

        print('User details moved to tasks collection successfully');
      } else {
        print('Payment not completed yet.');
      }
    } else {
      print('No user data found');
    }
  }

  Future<void> setSessionTrue() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'session': true,
      });

      print('Payment status updated to true');
    } catch (error) {
      print('Error updating payment status: $error');
      // Handle error
    }
  }
}
