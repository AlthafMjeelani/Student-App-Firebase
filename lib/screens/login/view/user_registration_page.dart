import 'package:firebaseaut/screens/dashboard/controller/dashboeard_provider.dart';
import 'package:firebaseaut/screens/login/controller/authentication_registration_provider.dart';
import 'package:firebaseaut/screens/profile/controller/profile_controller.dart';
import 'package:firebaseaut/utils/core/constent_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenUserRegistration extends StatelessWidget {
  const ScreenUserRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<FirebaseAuthSignUPProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      data.emailRegController.clear();
      data.nameRegController.clear();
      data.passwordRegController.clear();

      await Provider.of<ProfileProvider>(context, listen: false).getData();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('FirebaseAut'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: data.formKeySignIn,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) =>
                      data.validation(value, 'Enter your Name'),
                  controller: data.nameRegController,
                  decoration: InputDecoration(
                    label: const Text('Full Name'),
                    prefixIcon: const Icon(Icons.abc),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ConstentWidget.kWidth20,
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      data.validation(value, 'Enter your Email'),
                  controller: data.emailRegController,
                  decoration: InputDecoration(
                    label: const Text('Email Id'),
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ConstentWidget.kWidth20,
                TextFormField(
                  validator: (value) =>
                      data.validation(value, 'Enter your Password'),
                  controller: data.passwordRegController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password_outlined),
                    label: const Text('Password'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ConstentWidget.kWidth32,
                Consumer<FirebaseAuthSignUPProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return value.isLoading
                        ? const CupertinoActivityIndicator(
                            color: Colors.cyan,
                          )
                        : TextButton.icon(
                            onPressed: () async {
                              if (data.formKeySignIn.currentState!.validate()) {
                                await data.createUserAccount(
                                    data.emailRegController.text,
                                    data.passwordRegController.text,
                                    context);
                              }
                            },
                            icon: const Icon(Icons.app_registration_rounded),
                            label: const Text('Register'),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
