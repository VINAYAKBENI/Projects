import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard(
      {super.key,
      required this.title,
      required this.iconData,
      required this.time,
      required this.check,
      required this.onChange,
      required this.index});

  final String title;
  final IconData iconData;
  final String time;
  final bool check;
  final Function onChange;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        Theme(
          data: ThemeData(
            primarySwatch: Colors.blue,
            unselectedWidgetColor: const Color(0xff5e616a),
          ),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              activeColor: const Color(0xff6cf8a9),
              checkColor: const Color(0xff0e3e26),
              value: check,
              onChanged: (value) {
                onChange(index);
              },
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 75,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: const Color(0xff2a2e3d),
              child: Row(children: [
                const SizedBox(width: 15),
                Icon(iconData),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 15),
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
