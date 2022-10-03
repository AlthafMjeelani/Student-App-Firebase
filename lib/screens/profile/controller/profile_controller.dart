import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseaut/screens/login/model/user_model.dart';
import 'package:firebaseaut/screens/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier {
  ProfileProvider() {
    //getProfileImage();
  }
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  File? image;
  bool imageVisibility = false;

  String? downloadUrl;
  Future<void> getImage(ImageSource source) async {
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
      log(
        e.toString(),
      );
    }
  }

  Future<void> uploeadPick(String? userid) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('$userid/images');
    await reference.putFile(image!);
    notifyListeners();
  }

  void getProfileImage() async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('${auth.currentUser!.email}/images');
    downloadUrl = await reference.getDownloadURL();
    notifyListeners();
    log(downloadUrl!);
  }

  Future<void> submitUpdate(String? userid, context) async {
    // if (image != null) {
    //   await uploeadPick(userid);
    // } else {
    //   log('not called');
    // }
    UserModel userModel = UserModel(
      email: auth.currentUser!.email.toString(),
      name: nameController.text,
    );
    await firebaseFirestore
        .collection(auth.currentUser!.email.toString())
        .doc(auth.currentUser!.uid)
        .update(userModel.toMap());
    notifyListeners();
    log('submit called');
    Navigator.pop(context);
  }
}
