import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbagemana/auth/register.dart';
import 'package:garbagemana/user/pass.dart';
import 'package:garbagemana/user/user_dashboard.dart';
import 'package:garbagemana/user/user_register.dart';
import 'package:garbagemana/worker_or_admin.dart';

// Import the AuthService class

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserLogin(),
    ));

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> loginUser() async {
    try {
      User? user = await _authService.signInUserWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        // Handle successful login
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
      } else {
        // Handle failed login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    } catch (e) {
      // Handle error during login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

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
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      width: 180, // Set a specific width for the container
                      height: 200,
                      top: 40,
                      left: 10,
                      child: Container(
                        width: 220, // Set a specific width for the container
                        height: 300, // Set a specific height for the container
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/welcome.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email ",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 227, 218, 234),
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color.fromARGB(255, 107, 100, 237)
                            .withOpacity(0.7),
                      ),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 25, 0, 0),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 222, 211, 228),
                        ),
                        filled: true,
                        border: InputBorder.none,
                        fillColor: const Color.fromARGB(255, 107, 100, 237)
                            .withOpacity(0.7),
                      ),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 13, 0, 0),
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pass()),
                ),
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 107, 100, 237),
                ),
                child: TextButton(
                  onPressed: loginUser,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const userreg(),
                    ),
                  );
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Color.fromARGB(255, 3, 0, 0),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const wora(),
                    ),
                  );
                },
                child: const Text(
                  "Not a client?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 3, 0, 0),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Positioned(
                width: 780, // Set a specific width for the container
                height: 1000,
                bottom: 40,
                right: 0,
                child: Container(
                  width: 520, // Set a specific width for the container
                  height: 300, // Set a specific height for the container
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/welcome.gif'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
