import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserLocation(double latitude, double longitude) async {
    try {
      String? uid = ''; // Replace with actual user ID retrieval logic
      await _firestore.collection('users').doc(uid).update({
        'latitude': latitude,
        'longitude': longitude,
      });
      print('User location updated successfully');
    } catch (e) {
      print('Error updating user location: $e');
      // Handle error
    }
  }

  // Add more methods here for updating other user data
}
