import 'package:flutter/material.dart';

class TelaDenunciasWidget extends StatelessWidget {
  const TelaDenunciasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('atensao atensao'),
        backgroundColor: const Color(0xFFF4A905),
        titleTextStyle: const TextStyle(
          color: Colors.white, // Set the text color here
          fontSize: 18, // Optional: adjust font size
          fontWeight: FontWeight.w600, // Optional: adjust font weight
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image that covers the entire screen
          Image.asset(
            'images/carloshenrique.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
