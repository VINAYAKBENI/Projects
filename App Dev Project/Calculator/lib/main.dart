import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calc());
}

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  // Variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  // Colors
  static const operatorColor = Color(0xff272727);
  static const buttonColor = Color(0xff191919);
  static const orangeColor = Color(0xffD9802E);

  // Button Onpress Function
  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == '<-') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        Parser p = Parser();
        Expression expression = p.parse(input);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toStringAsFixed(5);
        if (output.endsWith(".00000")) {
          output = output.substring(0, output.length - 6);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input += value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Input
                    Text(
                      hideInput ? '' : input,
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Output
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.65),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              // Calculator Buttons
              children: [
                button(text: 'AC', tColor: orangeColor, bgColor: operatorColor),
                button(text: '<-', tColor: orangeColor, bgColor: operatorColor),
                button(text: '%', bgColor: operatorColor),
                button(text: '/', bgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(text: '7'),
                button(text: '8'),
                button(text: '9'),
                button(text: '*', bgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(text: '4'),
                button(text: '5'),
                button(text: '6'),
                button(text: '-', bgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(text: '1'),
                button(text: '2'),
                button(text: '3'),
                button(text: '+', bgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(text: '00'),
                button(text: '0'),
                button(text: '.', bgColor: operatorColor),
                button(text: '=', bgColor: orangeColor),
              ],
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

// Button Widget
  Widget button({text, tColor = Colors.white, bgColor = buttonColor}) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: bgColor,
              padding: const EdgeInsets.all(22),
            ),
            onPressed: () => onButtonClick(text),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22,
                color: tColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
