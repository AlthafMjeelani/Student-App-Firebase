import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/screens/adduser/model/enum_model.dart';
import 'package:firebaseaut/screens/adduser/model/user_details_model.dart';
import 'package:firebaseaut/screens/adduser/view/screen_adduser.dart';
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
  bool isLoading = false;
  List<DetailsModel> studentList = [];

  void addNewUser(context) async {
    DetailsModel newUser = DetailsModel(
        name: nameController.text,
        age: ageController.text,
        domain: domainController.text,
        mobileNumber: mobController.text,
        uid: uid);

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

  // Stream<List<DetailsModel>> fetchAllStudents() {
  //   return FirebaseFirestore.instance
  //       .collection(auth.currentUser!.email.toString())
  //       .doc(auth.currentUser!.uid)
  //       .collection('newUser')
  //       .snapshots()
  //       .asyncMap(
  //     (event) async {
  //       List<DetailsModel> students = [];
  //       for (var element in event.docs) {
  //         final st = DetailsModel.fromMap(element.data());
  //         students.add(st);
  //         notifyListeners();
  //       }
  //       return students;
  //     },
  //   );
  // }

  Future<void> getAllStudents(context) async {
    try {
      isLoading = true;
      final studentCollection = await FirebaseFirestore.instance
          .collection(auth.currentUser!.email.toString())
          .doc(auth.currentUser!.uid)
          .collection('newUser')
          .get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> documentList =
          studentCollection.docs;
      studentList = [];
      for (var element in documentList) {
        final studentData = DetailsModel.fromMap(element.data());

        studentList.insert(0, studentData);
        isLoading = false;
        // studentList.add(studentData);
      }
      notifyListeners();
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      return ShowSnackBar().showSnackBar(context, Colors.green, e.toString());
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
    notifyListeners();
  }

  void navigationToEdit(context, DetailsModel student) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ScreenAddUser(
          type: ActionType.editscreen,
          student: student,
        ),
      ),
    );
  }

  Future<void> updateStudents(String uid, context) async {
    if (formKey.currentState!.validate()) {
      // _isLoading = true;
      // notifyListeners();

      try {
        DetailsModel newUser = DetailsModel(
            name: nameController.text,
            age: ageController.text,
            domain: domainController.text,
            mobileNumber: mobController.text,
            uid: uid);
        await firebaseFirestore
            .collection(auth.currentUser!.email.toString())
            .doc(auth.currentUser!.uid)
            .collection('newUser')
            .doc(uid)
            .update(newUser.toMap());
        Navigator.pop(context);
        // _isLoading = false;
        notifyListeners();
        log('submit called');
      } catch (e) {
        log(e.toString());
      }
      //  Navigator.pop(context);
    }
  }
}
