import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garbagemana/auth/register.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  bool? taskCompleted;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      userData = await _authService.getUserData(user!.uid);
      if (userData != null) {
        _nameController.text = userData!['name'];
        _phoneController.text = userData!['phoneNumber'];
        _addressController.text = userData!['address'];
        _stateController.text = userData!['state'];
        _pinCodeController.text = userData!['pinCode'];
        taskCompleted = userData!['task_completed'];
      }
      setState(() {});
    }
  }

  Future<void> updateUserData() async {
    if (user != null) {
      await _authService.updateUserData(user!.uid, {
        'name': _nameController.text,
        'phoneNumber': _phoneController.text,
        'address': _addressController.text,
        'state': _stateController.text,
        'pinCode': _pinCodeController.text,
      });
      fetchUserData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Profile Page',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 107, 100, 237),
                  ),
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromARGB(255, 107, 100, 237),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 107, 100, 237),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 107, 100, 237),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _phoneController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 107, 100, 237),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _addressController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 107, 100, 237),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _stateController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'State',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 107, 100, 237),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _pinCodeController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Pin Code',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: updateUserData,
                  child: const Text('Update Profile'),
                ),
                if (taskCompleted != null)
                  Text(
                    taskCompleted! ? 'Task Completed' : 'Task Not Completed',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: taskCompleted! ? Colors.green : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }
}
