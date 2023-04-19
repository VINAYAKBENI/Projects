import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Service/auth_service.dart';
import 'package:todo/pages/home_page.dart';
import 'signup_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late StreamSubscription<User?> user;

  Widget currentPage = const SignUpPage();
  Authclass authclass = Authclass();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        //print('User is currently signed out!');
        setState(() {
          currentPage=const HomePage();
        });
      } 
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  void checkLogin() async {
    String? token = await authclass.getToken();

    if (token != '') {
      setState(() {
        currentPage = const HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AnimatedSplashScreen(
        backgroundColor: Colors.black12,
        splash: "assets/todo.png",
        splashIconSize: MediaQuery.of(context).size.width - 120,
        //nextScreen: currentPage,
        nextScreen: currentPage,
        splashTransition: SplashTransition.sizeTransition,
      ),
    );
  }
}
