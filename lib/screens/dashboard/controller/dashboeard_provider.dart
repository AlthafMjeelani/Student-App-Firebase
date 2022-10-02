import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/screens/profile/view/screen_profile.dart';
import 'package:firebaseaut/screens/login/model/user_model.dart';
import 'package:firebaseaut/screens/dashboard/view/screen_adduser.dart';
import 'package:flutter/material.dart';

class DashBoardProvider with ChangeNotifier {
  final TextEditingController firstNameRegController = TextEditingController();
  final TextEditingController ageRegController = TextEditingController();

  UserModel? userModel;
  Future<void> getData() async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        userModel = UserModel.fromMap(value.data()!);
        log(userModel.toString());
      });
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  String? validation(value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
    return null;
  }

  void navigationToAdd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ScreenAddUser(),
      ),
    );
  }

  void navigationToProfile(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ScreenProfile(),
      ),
    );
  }
}
