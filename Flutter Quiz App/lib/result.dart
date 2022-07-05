import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final VoidCallback reset;

  // ignore: use_key_in_widget_constructors
  const Result(this.score, this.reset);

  String get phase {
    String text;
    if (score <= 8) {
      text = 'You Are AWesome and innocent';
    } else if (score <= 12) {
      text = 'Pretty Likeable';
    } else if (score <= 16) {
      text = 'You Are ... Strange';
    } else {
      text = 'You Are BAd';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            phase,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: reset,
            child: const Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
