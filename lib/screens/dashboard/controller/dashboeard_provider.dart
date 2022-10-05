import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/screens/adduser/model/enum_model.dart';
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

  String? validation(value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
    return null;
  }

  void navigationToAdd(
    context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ScreenAddUser(
          type: ActionType.addScreen,
        ),
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
