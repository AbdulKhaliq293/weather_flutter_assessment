import 'package:flutter/material.dart';

class FallbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fallback Screen'),
      ),
      body: Center(
        child: Text('This is the fallback screen.'),
      ),
    );
  }
}
