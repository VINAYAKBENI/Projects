// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:todo/Service/Auth_Service.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = 'Send';
  TextEditingController phoneController = TextEditingController();

  Authclass authclass = Authclass();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            textField(),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  const Text(
                    'Enter 6 Digit OTP',
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            otpField(),
            const SizedBox(
              height: 30,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Send OTP again in ',
                    style: TextStyle(color: Colors.yellowAccent, fontSize: 16),
                  ),
                  TextSpan(
                    text: '00:$start',
                    style:
                        const TextStyle(color: Colors.pinkAccent, fontSize: 16),
                  ),
                  const TextSpan(
                    text: ' sec',
                    style: TextStyle(color: Colors.yellowAccent, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            InkWell(
              onTap: () {
                authclass.signInwithPhoneNumber(
                    verificationIdFinal, smsCode, context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffff9601),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'Let\'s Go',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
          start = 30;
          //buttonName='Send';
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 30,
      fieldWidth: 48,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: const Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        // ignore: avoid_print
        print("Completed: $pin");
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        keyboardType: const TextInputType.numberWithOptions(),
        onEditingComplete: wait
            ? null
            : () async {
                startTimer();
                setState(() {
                  wait = true;
                  buttonName = 'Resend';
                });
                await authclass.verifyPhoneNumber(
                    "+91 ${phoneController.text}", context, setData);
              },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your Phone Number',
          hintStyle: const TextStyle(fontSize: 17, color: Colors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              '( +91 )',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    startTimer();
                    setState(() {
                      wait = true;
                      buttonName = 'Resend';
                    });
                    await authclass.verifyPhoneNumber(
                        "+91 ${phoneController.text}", context, setData);
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  fontSize: 17,
                  color: wait ? Colors.grey : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
