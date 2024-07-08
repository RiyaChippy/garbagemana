import 'package:cloud_firestore/cloud_firestore.dart';

class Workers {
  final CollectionReference _workersCollection =
      FirebaseFirestore.instance.collection('workers');

  Future<void> addWorker(String name, String email, String phoneNumber) async {
    await _workersCollection.add({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }

  Future<List<Map<String, dynamic>>> getWorkers() async {
    QuerySnapshot querySnapshot = await _workersCollection.get();
    List<Map<String, dynamic>> workers = querySnapshot.docs
        .map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return workers;
  }

  Future<void> updateWorker(
      String workerId, String name, String email, String phoneNumber) async {
    await _workersCollection.doc(workerId).update({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }

  Future<void> deleteWorker(String workerId) async {
    await _workersCollection.doc(workerId).delete();
  }
}
