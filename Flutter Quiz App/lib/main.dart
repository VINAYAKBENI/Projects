import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _question = const [
    {
      'questiontext': 'What\'s your favourite colour ?',
      'answer': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questiontext': 'what\'s your favourite animal ?',
      'answer': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questiontext': 'who\'s your favourite instructor ?',
      'answer': [
        {'text': 'Max', 'score': 1},
        {'text': 'Jack', 'score': 1},
        {'text': 'Buttler', 'score': 1},
        {'text': 'Roy', 'score': 1},
      ],
    },
  ];

  int _total = 0;
  var _i = 0;

  void _button(int score) {
    _total += score;
    setState(() {
      _i++;
    });
  }

  void _reset() {
    setState(() {
      _i = 0;
      _total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My First App'),
        ),
        body: _i < _question.length
            ? Quiz(
                question: _question,
                button: _button,
                i: _i,
              )
            : Result(_total, _reset),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
