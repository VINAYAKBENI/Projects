import 'package:flutter/material.dart';

class Question extends StatelessWidget {
 final String questext;

  // ignore: use_key_in_widget_constructors
  const Question(this.questext);  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      child: Text(
        questext,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 40),
      ),
    );
  }
}
