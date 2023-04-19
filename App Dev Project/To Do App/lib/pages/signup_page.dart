// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo/Service/Auth_Service.dart';
import 'package:todo/pages/phoneauth_page.dart';

import 'signin_page.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  bool circular = false;
  Authclass authclass = Authclass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sign Up Text On Page
              const Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              // Google Signin Button
              buttonItem("assets/google.svg", "Continue With Google", 25,
                  () async {
                await authclass.googleSignIn(context);
              }),
              const SizedBox(
                height: 15,
              ),
              buttonItem("assets/phone.svg", "Continue With Moblie", 30, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const PhoneAuthPage()),
                );
              }),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Or",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              textItem(' Email', _emailcontroller, false),
              const SizedBox(
                height: 15,
              ),
              textItem(' Password', _pwdcontroller, true),
              const SizedBox(
                height: 30,
              ),
              colorButton(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'If you already have an Account ?  ',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const SignInPage()),
                          (route) => false);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailcontroller.text, password: _pwdcontroller.text);
          // ignore: avoid_print
          print(userCredential.user?.email);

          setState(() {
            circular = false;
          });

          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c),
            ],
          ),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  Widget buttonItem(
      String imagePath, String buttonName, double size, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(width: 1, color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                height: size,
                width: size,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                buttonName,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String labeltext, TextEditingController controller, bool obsuretext) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        obscureText: obsuretext,
        controller: controller,
        style: const TextStyle(fontSize: 17),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          //labelText: labeltext,
          hintText: labeltext,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
