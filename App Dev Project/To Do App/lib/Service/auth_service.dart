// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../pages/home_page.dart';

class Authclass {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          storeTokenAndData(userCredential);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        const snackbar = SnackBar(content: Text('Not Able To Sign In'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: 'token', value: userCredential.credential?.token.toString());
    await storage.write(
        key: 'userCredential', value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await storage.delete(key: 'token');
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, 'Verification Completed');
    }

    verificationFailed(FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    }

    codeSent(String verificationID, [int? forceResendingtoken]) {
      showSnackBar(context, 'Verification Code Sent');
      setData(verificationID);
    }

    codeAutoRetrievalTimeout(String verificationID) {
      showSnackBar(context, 'Time Out');
    }

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      storeTokenAndData(userCredential);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const HomePage()),
          (route) => false);
      showSnackBar(context, 'Logged In');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
