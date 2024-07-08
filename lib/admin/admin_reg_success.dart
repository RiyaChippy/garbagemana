import 'package:flutter/material.dart';
import 'package:garbagemana/user/main1.dart';

class Succadreg extends StatefulWidget {
  const Succadreg({super.key, Key? key3});

  @override
  State<Succadreg> createState() => _SuccRegState();
}

class _SuccRegState extends State<Succadreg> {
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
                            image: AssetImage('assets/images/welcome3.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text(
                            "Successfully Registered",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  30, // Increased font size for better visibility
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 107, 100, 237),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserLogin()),
                      );
                    },
                    child: const Text(
                      "Go back to login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
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
                      image: AssetImage('assets/images/done.gif'),
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
}
