import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garbagemana/auth/register.dart';
import 'package:garbagemana/user/main1.dart';
import 'package:garbagemana/user/successfully_registerd.dart';

// ignore: camel_case_types
class userreg extends StatefulWidget {
  const userreg({super.key});

  @override
  State<userreg> createState() => _UserRegState();
}

class _UserRegState extends State<userreg> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();

  void _registerUser() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    User? user = await _authService.registerWithEmailAndPassword(
      _nameController.text,
      _phoneNumberController.text,
      _emailController.text,
      _addressController.text,
      _stateController.text,
      _pinCodeController.text,
      _passwordController.text,
    );

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User registered successfully")),
      );
      _nameController.clear();
      _phoneNumberController.clear();
      _emailController.clear();
      _addressController.clear();
      _stateController.clear();
      _pinCodeController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Succreg()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed")),
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
                      width: 180,
                      height: 200,
                      top: 40,
                      left: 10,
                      child: Container(
                        width: 220,
                        height: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/welcome2.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("Name", _nameController),
              const SizedBox(height: 20), // Increased spacing
              _buildTextField("Phone Number", _phoneNumberController),
              const SizedBox(height: 20), // Increased spacing
              _buildTextField("Email", _emailController),
              const SizedBox(height: 20), // Increased spacing
              _buildTextField("Address", _addressController),
              const SizedBox(height: 20), // Increased spacing
              _buildTextField("State", _stateController),
              const SizedBox(height: 20), // Increased spacing
              _buildTextField("Pin Code", _pinCodeController),
              const SizedBox(height: 20), // Increased spacing
              _buildTextField("Password", _passwordController,
                  obscureText: true),
              const SizedBox(height: 20), // Increased spacing
              _buildTextField("Confirm Password", _confirmPasswordController,
                  obscureText: true),
              const SizedBox(height: 20), // Increased spacing

              const SizedBox(height: 20),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 90),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 107, 100, 237),
                ),
                child: TextButton(
                  onPressed: _registerUser,
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 107, 100, 237),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserLogin()),
                    );
                  },
                  child: const Center(
                    child: Text(
                      "Already Registered?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Positioned(
                width: 180, // Set a specific width for the container
                height: 200,
                bottom: 40,
                right: 10,
                child: Container(
                  width: 220, // Set a specific width for the container
                  height: 300, // Set a specific height for the container
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/register.gif'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Rounded edges
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 142, 137, 239).withOpacity(0.7),
        ),
        style: const TextStyle(color: Color.fromARGB(255, 13, 0, 0)),
        obscureText: obscureText,
      ),
    );
  }
}
