import 'package:firebaseaut/screens/login/controller/authentication_registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenUserRegistration extends StatelessWidget {
  const ScreenUserRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<FirebaseAuthSignUPProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data.emailRegController.clear();
      data.passwordRegController.clear();
      data.firstNameRegController.clear();
      data.secondNameRegController.clear();
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
                  validator: (value) =>
                      data.validation(value, 'Enter your Name'),
                  controller: data.firstNameRegController,
                  decoration: InputDecoration(
                    label: const Text('First Name'),
                    prefixIcon: const Icon(Icons.abc),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      data.validation(value, 'Enter your Age'),
                  controller: data.secondNameRegController,
                  decoration: InputDecoration(
                    label: const Text('Age'),
                    prefixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                const SizedBox(
                  height: 20,
                ),
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
                const SizedBox(
                  height: 32,
                ),
                TextButton.icon(
                  onPressed: () async {
                    if (data.formKeySignIn.currentState!.validate()) {
                      await data.createUserAccount(data.emailRegController.text,
                          data.passwordRegController.text, context);
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
