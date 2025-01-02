import 'package:flutter/material.dart';
import 'dart:ui';

class BG extends StatelessWidget {
  const BG({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/main_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Container(
            height: double.infinity,
            width: screenWidth * 0.9, // 90% width
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 17, 220, 232)
                  .withOpacity(0.1), // Semi-transparent color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blurry effect
            ),
          ),
        ),
      ],
    );
  }
}
