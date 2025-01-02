import 'package:flutter/material.dart';

class MyCustomTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final controller;

  const MyCustomTextField({Key? key, required this.hintText, required this.obscureText, required this.controller}) : super(key: key); // Modify the constructor

  @override
  State<MyCustomTextField> createState() => _MyCustomTextFieldState();
}

class _MyCustomTextFieldState extends State<MyCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText, 
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
