import 'package:flutter/material.dart';
import 'thirdscreen.dart';

class Ranking extends StatelessWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF731816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF731816),
        centerTitle: true,
        title: const Text(
          "STAND",
          style: TextStyle(color: Color(0xFF00AADE)),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: const Text('Third screen'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ThirdScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
