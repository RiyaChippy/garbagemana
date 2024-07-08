import 'package:flutter/material.dart';
import 'package:garbagemana/admin/profile.dart';
import 'package:garbagemana/dash_board_user/home.dart';
import 'package:garbagemana/user/AboutUs.dart';
import 'package:garbagemana/user/Feedback.dart';
import 'package:garbagemana/user/help.dart';
import 'package:garbagemana/user/main1.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UserHome(),
    const AboutUsPage(),
    const ComingSoonPage(),
    const ProfilePage(),
  ];

  void _showPopupMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height /
              2, // Half of the screen height
          color: Colors.blue, // Blue background color
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.feedback, color: Colors.white),
                title: const Text('Feedback',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FeedbackPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.white),
                title:
                    const Text('Help', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserLogin()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("GarboManage"),
        backgroundColor: const Color.fromARGB(255, 107, 100, 237),
        toolbarHeight: 50,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showPopupMenu(context),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 107, 100, 237),
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'About Us',
            icon: Icon(Icons.tv_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Coming Soon',
            icon: Icon(Icons.inventory_sharp),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 107, 100, 237),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Define the different pages

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double
                    .infinity, // Ensures the container takes the full width available
                height: 500, // Specific height for the container
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/city2.gif'),
                    fit: BoxFit.cover, // Ensures the image covers the container
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We are working hard to bring you new features. Stay tuned!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
