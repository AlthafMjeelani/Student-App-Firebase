import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseaut/screens/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  File? image;
  bool imageVisibility = false;
  Future<void> getimage(ImageSource source) async {
    final pikImage = await ImagePicker().pickImage(
      source: source,
    );
    if (pikImage == null) {
      return;
    } else {
      final imageTemp = File(pikImage.path);
      image = imageTemp;
      notifyListeners();
      log("image picked ");
    }
  }

  void isVisible(img) {
    if (img == null) {
      imageVisibility = true;
    } else {
      imageVisibility = false;
    }

    notifyListeners();
  }

  Future<void> signOutPage(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const ScreenLogin(),
        ),
      );
      log('called');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> uploeadPick() async {}
}
