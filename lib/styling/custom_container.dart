import 'package:flutter/material.dart';

class CustomStyledContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double width;

  const CustomStyledContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0, 10),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: child,
    );
  }
}
