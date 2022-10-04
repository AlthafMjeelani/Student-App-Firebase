import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/screens/adduser/model/user_details_model.dart';
import 'package:firebaseaut/utils/snackbar.dart';
import 'package:flutter/material.dart';

class AddNewUserProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  DetailsModel? detailsModel;
  List<DetailsModel> list = [];
  final formKey = GlobalKey<FormState>();

  void addNewUser(context) async {
    DetailsModel newUser = DetailsModel(
      name: nameController.text,
      age: ageController.text,
      domain: domainController.text,
      mobileNumber: mobController.text,
    );

    await firebaseFirestore
        .collection(auth.currentUser!.email.toString())
        .doc(auth.currentUser!.uid)
        .collection(nameController.text)
        .doc(auth.tenantId)
        .set(newUser.toMap());
    ShowSnackBar()
        .showSnackBar(context, Colors.green, 'New user Creted Successfully');
    Navigator.pop(context);
  }

  String? validation(value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
    return null;
  }

  void getAllUsers() async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(firebaseFirestore.app.name)
          .doc(auth.tenantId)
          .get()
          .then((value) {
        detailsModel = DetailsModel.fromMap(value.data());
        log(detailsModel.toString());
      });
      notifyListeners();
    } catch (e) {
      log('get all user    ${e.toString()}');
    }
    return null;
  }
}
