import 'dart:io';

import 'package:firebaseaut/screens/dashboard/controller/dashboeard_provider.dart';
import 'package:firebaseaut/screens/profile/controller/profile_controller.dart';
import 'package:firebaseaut/utils/core/constent_widget.dart';
import 'package:firebaseaut/widgets/textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  alertDialog(context);
                },
                child: Consumer(
                  builder: (BuildContext context, ProfileProvider value,
                      Widget? child) {
                    return value.image == null
                        ? const CircleAvatar(
                            backgroundColor: Colors.black38,
                            radius: 70,
                            child: Icon(Icons.image),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(File(value.image!.path)),
                            radius: 70,
                          );
                  },
                ),
              ),
              ConstentWidget.kWidth20,
              Textfeildwidget(
                validator: (value) {},
                text: 'text',
                icon: Icons.abc,
                controller: data.ageRegController,
              ),
              ConstentWidget.kWidth20,
              Textfeildwidget(
                validator: (value) {},
                text: 'text',
                icon: Icons.abc,
                controller: data.ageRegController,
              ),
              ConstentWidget.kWidth20,
              Textfeildwidget(
                validator: (value) {},
                text: 'text',
                icon: Icons.abc,
                controller: data.ageRegController,
              ),
              ConstentWidget.kWidth20,
              Textfeildwidget(
                validator: (value) {},
                text: 'text',
                icon: Icons.abc,
                controller: data.ageRegController,
              ),
              ConstentWidget.kWidth32,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () async {},
                    icon: const Icon(Icons.app_registration_rounded),
                    label: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void alertDialog(context) {
  final data = Provider.of<ProfileProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () async {
                  await data.getimage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.image),
                label: const Text('Add image'),
              ),
              TextButton.icon(
                onPressed: () async {
                  data.getimage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Pick image'),
              )
            ],
          ),
        ],
      );
    },
  );
}
