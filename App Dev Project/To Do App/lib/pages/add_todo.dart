import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToDoPage extends StatefulWidget {
  const AddToDoPage({super.key});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _despController = TextEditingController();
  String type = '';
  String category = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff252041),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.arrow_left)),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff1d1e26),
              Color(0xff252041),
            ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      const Text(
                        'New Todo',
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 25),
                      label('Task Title'),
                      const SizedBox(height: 12),
                      title(),
                      const SizedBox(height: 30),
                      label('Task Type'),
                      const SizedBox(height: 12),
                      Row(children: [
                        taskSelect('Important', 0xff2664fa),
                        const SizedBox(width: 15),
                        taskSelect('Planned', 0xff2bc8d9),
                      ]),
                      const SizedBox(height: 25),
                      label('Description'),
                      const SizedBox(height: 12),
                      description(),
                      const SizedBox(height: 25),
                      label('Category'),
                      const SizedBox(height: 12),
                      Wrap(runSpacing: 10, children: [
                        categorySelect('Food', 0xffff6d6e),
                        const SizedBox(width: 15),
                        categorySelect('Workout', 0xfff29732),
                        const SizedBox(width: 15),
                        categorySelect('Design', 0xff6557ff),
                        const SizedBox(width: 15),
                        categorySelect('Work', 0xff234ebd),
                        const SizedBox(width: 15),
                        categorySelect('Run', 0xff2bc8d9),
                      ]),
                      const SizedBox(height: 50),
                      button(),
                      const SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection('Todo').add({
          'title': _titleController.text,
          'task': type,
          'description': _despController.text,
          'category': category,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: const Center(
          child: Text(
            'Add ToDo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _despController,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        maxLength: null,
        decoration: const InputDecoration(
          hintText: 'Description',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 15),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.grey : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            color: type == label ? Colors.black : Colors.white,
            fontWeight: type == label ? FontWeight.bold : FontWeight.w400,
            fontSize: type == label ? 19 : 15,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.grey : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            color: category == label ? Colors.black : Colors.white,
            fontWeight: category == label ? FontWeight.bold : FontWeight.w400,
            fontSize: category == label ? 19 : 15,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        decoration: const InputDecoration(
          hintText: 'Task Title',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 15),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16.5,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}
