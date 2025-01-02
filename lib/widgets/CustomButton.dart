import 'package:flutter/material.dart';

class Custombutton extends StatefulWidget {
  final String text;
  final Function function;


  const Custombutton({super.key, required this.text, required this.function});

  @override
  State<Custombutton> createState() => _CustombuttonState();
}

class _CustombuttonState extends State<Custombutton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Color(0xFF00E5E5), // #00E5E5
            Color(0xFF72A5F2), // #72A5F2
            Color(0xFFE961FF), // #E961FF
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: ElevatedButton(
        onPressed: () { widget.function(); },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
