import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_konsultasi_gus/Models/HomeScreen.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    print("Splashscreen dimulai...");
    startSplashScreen();
  }

  void startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/PngItem_2414416.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 24.0),
              const Text(
                "TanyaGus",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
