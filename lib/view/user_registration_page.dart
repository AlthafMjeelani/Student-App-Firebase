import 'package:firebaseaut/controller/authentication_signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenUserRegistration extends StatelessWidget {
  const ScreenUserRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<FirebaseAuthSignInProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data.emailController.clear();
      data.passwordController.clear();
      data.firstNameController.clear();
      data.secondNameController.clear();
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
                GestureDetector(
                  onTap: () {
                    alertDialog(context);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black38,
                    radius: 70,
                    child: Icon(Icons.image),
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
                  controller: data.firstNameController,
                  decoration: InputDecoration(
                    label: const Text('First Name'),
                    prefixIcon: const Icon(Icons.text_decrease_outlined),
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
                  controller: data.secondNameController,
                  decoration: InputDecoration(
                    label: const Text('Second Name'),
                    prefixIcon: const Icon(Icons.text_decrease_outlined),
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
                  controller: data.emailController,
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
                    if (value.length < 6) {
                      return 'Please enter Atleast 6 Cheracter';
                    }
                    return null;
                  },
                  controller: data.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password_outlined),
                    label: const Text('Password'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextButton.icon(
                  onPressed: () async {
                    if (data.formKeySignIn.currentState!.validate()) {
                      await data.createUserAccount(data.emailController.text,
                          data.passwordController.text, context);
                    }
                  },
                  icon: const Icon(Icons.app_registration_rounded),
                  label: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

void alertDialog(context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.image),
                label: const Text('Add image'),
              ),
              TextButton.icon(
                onPressed: () {},
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
