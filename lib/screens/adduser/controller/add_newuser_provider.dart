import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/screens/adduser/model/user_details_model.dart';
import 'package:firebaseaut/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddNewUserProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  DetailsModel? detailsModel;
  final formKey = GlobalKey<FormState>();
  String uid = const Uuid().v4();

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
        .collection('newUser')
        .doc(uid)
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

  Stream<List<DetailsModel>> fetchAllStudents() {
    return FirebaseFirestore.instance
        .collection(auth.currentUser!.email.toString())
        .doc(auth.currentUser!.uid)
        .collection('newUser')
        .snapshots()
        .asyncMap(
      (event) async {
        List<DetailsModel> students = [];
        for (var element in event.docs) {
          final st = DetailsModel.fromMap(element.data());
          students.add(st);
          notifyListeners();
        }
        return students;
      },
    );
  }
  // try {
  //   await FirebaseFirestore.instance
  //       .collection(FirebaseAuth.instance.currentUser!.email.toString())
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection(firebaseFirestore.app.name)
  //       .doc(auth.tenantId)
  //       .get()
  //       .then((value) {
  //     detailsModel = DetailsModel.fromMap(value.data()!);
  //     log(detailsModel.toString());
  //   });
  //   notifyListeners();
  // } catch (e) {
  //   log('get all user    ${e.toString()}');
  // }
  // return null;

}
