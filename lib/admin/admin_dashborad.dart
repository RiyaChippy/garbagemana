import 'package:flutter/material.dart';
import 'package:garbagemana/admin/UserFeedback.dart';
import 'package:garbagemana/admin/admin_login.dart';
import 'package:garbagemana/admin/adminworker.dart';
import 'package:garbagemana/admin/customer.dart';
import 'package:garbagemana/admin/profile.dart';

class addash extends StatefulWidget {
  const addash({super.key});

  @override
  State<addash> createState() => _AddashState();
}

class _AddashState extends State<addash> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WorkerPage(),
    UserPage(),
    UserFeedback(),
    const ProfilePage(),
  ];

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AdLog()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GarboManage"),
        backgroundColor: const Color.fromARGB(255, 107, 100, 237),
        toolbarHeight: 50,
      ),
      body: _currentIndex < _pages.length
          ? _pages[_currentIndex]
          : _pages[0], // Ensure valid index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 107, 100, 237),
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          if (newIndex == 4) {
            _showLogoutDialog(context);
          } else {
            setState(() {
              _currentIndex = newIndex;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Workers',
            icon: Icon(Icons.work),
          ),
          BottomNavigationBarItem(
            label: 'Customers',
            icon: Icon(Icons.group),
          ),
          BottomNavigationBarItem(
            label: 'Feedback',
            icon: Icon(Icons.note_add),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Logout',
            icon: Icon(Icons.logout),
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 107, 100, 237),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
