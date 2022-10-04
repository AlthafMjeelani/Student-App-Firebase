import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/screens/profile/view/screen_profile.dart';
import 'package:firebaseaut/screens/login/model/user_model.dart';
import 'package:firebaseaut/screens/adduser/view/screen_adduser.dart';
import 'package:flutter/material.dart';

class DashBoardProvider with ChangeNotifier {
  final TextEditingController firstNameRegController = TextEditingController();
  final TextEditingController ageRegController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserModel? userModel;
  Future<void> getData() async {
    try {
      _isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        userModel = UserModel.fromMap(value.data()!);
        log(userModel.toString());
      });
      _isLoading = false;
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
        builder: (ctx) => ScreenProfile(
          userId: FirebaseAuth.instance.currentUser!.email.toString(),
        ),
      ),
    );
  }
}
