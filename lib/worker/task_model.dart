import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String taskId;
  final String address;
  final Timestamp createdAt;
  final String email;
  final bool isWorker;
  final GeoPoint location;
  final String map;
  final String name;
  final String phoneNumber;
  final String pickupData;
  final String pinCode;
  final String role;
  final bool session;
  final String state;
  final List<dynamic> wasteTypes;
  final String workerId;

  Task({
    required this.taskId,
    required this.address,
    required this.createdAt,
    required this.email,
    required this.isWorker,
    required this.location,
    required this.map,
    required this.name,
    required this.phoneNumber,
    required this.pickupData,
    required this.pinCode,
    required this.role,
    required this.session,
    required this.state,
    required this.wasteTypes,
    required this.workerId,
  });

  factory Task.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Task(
      taskId: doc.id,
      address: data['address'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      email: data['email'] ?? '',
      isWorker: data['isWorker'] ?? false,
      location: data['location'] ?? GeoPoint(0, 0),
      map: data['map'] ?? '',
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      pickupData: data['pickupData'] ?? '',
      pinCode: data['pinCode'] ?? '',
      role: data['role'] ?? '',
      session: data['session'] ?? false,
      state: data['state'] ?? '',
      wasteTypes: data['wasteTypes'] ?? [],
      workerId: data['workerId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'address': address,
      'createdAt': createdAt,
      'email': email,
      'isWorker': isWorker,
      'location': location,
      'map': map,
      'name': name,
      'phoneNumber': phoneNumber,
      'pickupData': pickupData,
      'pinCode': pinCode,
      'role': role,
      'session': session,
      'state': state,
      'wasteTypes': wasteTypes,
      'workerId': workerId,
    };
  }
}
