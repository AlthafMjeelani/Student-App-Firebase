import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier {
  final TextEditingController firstNameRegController = TextEditingController();
  final TextEditingController ageRegController = TextEditingController();
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
}
