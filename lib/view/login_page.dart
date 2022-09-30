import 'dart:developer';

import 'package:firebaseaut/controller/authentication_login_provider.dart';
import 'package:firebaseaut/controller/exeption.dart';
import 'package:firebaseaut/view/screen_dashboard.dart';
import 'package:firebaseaut/view/user_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final formKeyLogIn = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FirebaseAuthLogInProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data.emailSigninController.clear();
      data.passwordSigninController.clear();
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
          key: formKeyLogIn,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: data.emailSigninController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: const Text('Email Id'),
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: data.passwordSigninController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password_outlined),
                  label: const Text('Password'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  if (formKeyLogIn.currentState!.validate()) {
                    await data
                        .signInUserAccount(data.emailSigninController.text,
                            data.passwordSigninController.text, context)
                        .onError(
                            (error, stackTrace) => errorHandle(context, error));
                  }
                },
                icon: const Icon(Icons.login_outlined),
                label: const Text('Login'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const ScreenUserRegistration(),
                    ),
                  );
                },
                child: const Text('New User? Register Now'),
              )
            ],
          ),
        ),
      )),
    );
  }

  errorHandle(error, context) {
    if (error is FirebaseExceptionShowing) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid UserName or Password'),
        ),
      );
    }
  }
}
