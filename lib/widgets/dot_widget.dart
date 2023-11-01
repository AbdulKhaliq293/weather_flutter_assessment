import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final bool isActive;

  Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      width: 8.0, // Adjust the size as needed
      height: 8.0, // Adjust the size as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? Colors.white
            : Colors.black12, // Active and inactive colors
      ),
    );
  }
}
