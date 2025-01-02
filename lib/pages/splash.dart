import 'dart:async';
import 'package:cosmic/pages/Home.dart';
import 'package:cosmic/widgets/bg.dart';
import 'package:cosmic/widgets/loader.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    // Start a timer to navigate to the home screen after 3 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const Home()), // Change to your next screen
      );
    });

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          const BG(),
          // Centered loader
          Center(
            child: SizedBox(
              width: screenWidth * 0.75,
              child: Center(child: CosmicLoader()),
            ),
          ),
          // Positioned image
          Positioned(
            bottom: 15, // Position the image 150 pixels above the bottom
            left: screenWidth / 4, // Center the image horizontally
            child: Image.asset(
              "assets/img/flutter_logo.png",
              width: 200, // Adjust the width as needed
            ),
          ),
        ],
      ),
    );
  }
}
