import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 56, 55, 60),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.arrow_left)),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 60,
                backgroundImage: getImage(),
              ),
              const SizedBox(height: 15),
              const Text(
                'Change Profile Image',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 55),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(),
                ],
              ),
            ],
          )),
    );
  }

  ImageProvider getImage() {
    // ignore: unnecessary_null_comparison
    if (image != null) {
      return FileImage(File(image!.path));
    }
    return const AssetImage('assets/profile.png');
  }

  Widget button() {
    return InkWell(
      onTap: () async {
        image = await _picker.pickImage(source: ImageSource.gallery);
        setState(() {
          image = image;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 55,
        width: MediaQuery.of(context).size.width-40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: const Center(
          child: Text(
            'Choose from Gallery',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
