import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback button;
  final String? ques;
  // ignore: use_key_in_widget_constructors
  const Answer({
    required this.ques,
    required this.button,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: button,
        child: Text(ques!),
      ),
    );
  }
}
