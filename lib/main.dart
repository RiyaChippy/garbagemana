import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garbagemana/firebase_options.dart';
import 'package:garbagemana/user/main1.dart'; // Ensure this is the correct import for your UserLogin
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Set this inside MaterialApp
      home: const OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            children: [
              buildPage(
                imagePath: 'assets/images/waste.gif',
                text:
                    'Cleaning alone is not enough. Effective waste disposal is now a necessity.',
              ),
              buildPage(
                imagePath: 'assets/images/earth.gif',
                text: 'Let us now work together to create a green world.',
              ),
              buildPage(
                imagePath: 'assets/images/cleaning.gif',
                text: 'Join us in this journey to keep the environment clean.',
              )
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text('SKIP'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserLogin(),
                    ),
                  );
                },
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                ),
              ),
              TextButton(
                child: const Text(''),
                onPressed: () {},
              )
            ],
          ),
        ),
      );

  Widget buildPage({required String imagePath, required String text}) {
    return Stack(
      children: <Widget>[
        Positioned(
          width: 280,
          height: 400,
          top: 40,
          left: 80,
          child: Container(
            width: 220,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
              ),
            ),
          ),
        ),
        Positioned(
          top: 480,
          left: 20,
          right: 20,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black, // Changed to black for better readability
                fontSize: 20, // Adjusted font size for better fit
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
