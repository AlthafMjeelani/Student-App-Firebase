import 'dart:io';
import 'package:firebaseaut/screens/dashboard/controller/dashboeard_provider.dart';
import 'package:firebaseaut/screens/profile/controller/profile_controller.dart';
import 'package:firebaseaut/utils/alert_dialoge.dart';
import 'package:firebaseaut/utils/core/constent_widget.dart';
import 'package:firebaseaut/widgets/textfeild_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({
    super.key,
    required this.userId,
  });
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProfileProvider>(context, listen: false);
    final dashboard = Provider.of<DashBoardProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (dashboard.userModel == null) {
        return;
      } else {
        data.nameController.text = dashboard.userModel!.name.toString();
        data.emailController.text = dashboard.userModel!.email.toString();
        Provider.of<ProfileProvider>(context, listen: false)
            .getProfileImage(userId);
        data.image = null;
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await data.signOutPage(context);
              data.image = null;
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: data.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Consumer(
                  builder: (BuildContext context, ProfileProvider value,
                      Widget? child) {
                    return value.isLoading
                        ? const Padding(
                            padding: EdgeInsets.only(left: 30, top: 20),
                            child: CupertinoActivityIndicator(
                              color: Colors.cyan,
                            ))
                        : GestureDetector(
                            onTap: () {
                              SimpleDialogWidget.alertDialog(context);
                            },
                            child: Stack(
                              children: [
                                value.image == null
                                    ? value.downloadUrl == null
                                        ? const CircleAvatar(
                                            backgroundColor: Colors.black38,
                                            radius: 70,
                                            child: Icon(Icons.image),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              value.downloadUrl!,
                                            ),
                                            radius: 70,
                                          )
                                    : CircleAvatar(
                                        backgroundImage: FileImage(
                                          File(value.image!.path),
                                        ),
                                        radius: 70,
                                      ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 110.0, left: 100),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 32,
                                  ),
                                )
                              ],
                            ),
                          );
                  },
                ),
                ConstentWidget.kWidth32,
                Textfeildwidget(
                  readOnly: false,
                  validator: (value) =>
                      data.validation(value, "Enter Your Name"),
                  text: 'Enter Name',
                  icon: Icons.abc,
                  controller: data.nameController,
                ),
                ConstentWidget.kWidth20,
                Textfeildwidget(
                  readOnly: true,
                  validator: (value) {
                    return;
                  },
                  text: 'Enter emailid',
                  icon: Icons.abc,
                  controller: data.emailController,
                ),
                ConstentWidget.kWidth32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<ProfileProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        return value.isLoading
                            ? const CupertinoActivityIndicator(
                                color: Colors.cyan,
                              )
                            : TextButton.icon(
                                onPressed: () async {
                                  await data.submitUpdate(userId, context);
                                  await dashboard.getData();
                                },
                                icon:
                                    const Icon(Icons.app_registration_rounded),
                                label: const Text('Save'),
                              );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
