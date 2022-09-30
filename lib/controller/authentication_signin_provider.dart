import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/controller/exeption.dart';
import 'package:firebaseaut/model/deatails_model.dart';
import 'package:firebaseaut/view/screen_dashboard.dart';
import 'package:flutter/material.dart';

class FirebaseAuthSignInProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();

  final formKeySignIn = GlobalKey<FormState>();
  DetailsModel? model;
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<void> createUserAccount(String email, String password, context) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      model!.userId = userCredential.user!.uid;
      model!.email = userCredential.user!.email;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (ctx) => const ScreenDashBoard(),
          ),
          (route) => false);
    } on FirebaseAuthException {
      throw FirebaseExceptionShowing(massage: 'Invalid EmailId or Password');
    }
  }

  void signOutPage() async {
    await auth.signOut();
    log('called');
  }
}
