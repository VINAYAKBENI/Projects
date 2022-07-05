import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final int i;
  final List<Map<String, Object>> question;
  final Function button;

  // ignore: use_key_in_widget_constructors
  const Quiz({
    required this.question,
    required this.button,
    required this.i,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          question[i]['questiontext'] as String,
        ),
        ...(question[i]['answer'] as List<Map<String, Object>>).map((ans) {
          return Answer(
            button: () => button(ans['score']),
            ques: ans['text']! as String,
          );
        }).toList()
      ],
    );
  }
}
