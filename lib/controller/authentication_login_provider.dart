import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/model/deatails_model.dart';
import 'package:firebaseaut/view/login_page.dart';
import 'package:firebaseaut/view/screen_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseAuthLogInProvider with ChangeNotifier {
  final TextEditingController emailSigninController = TextEditingController();
  final TextEditingController passwordSigninController =
      TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  DetailsModel? model;

  Future<void> signInUserAccount(String email, String password, context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (ctx) => const ScreenDashBoard(),
          ),
          (route) => false);
    } catch (e) {
      throw ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
