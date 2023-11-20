import 'package:flutter/material.dart';
import 'package:zoom_replica/resources/auth_methods.dart';
import 'package:zoom_replica/widgets/custom_buttom.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(text: 'Log Out', onpressed: () {
      AuthMethods().signOut();
      Navigator.popAndPushNamed(context, '/login');
    });
  }
}