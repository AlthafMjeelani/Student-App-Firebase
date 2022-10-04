import 'package:firebaseaut/screens/login/controller/authentication_login_provider.dart';
import 'package:firebaseaut/screens/login/view/user_registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FirebaseAuthLogInProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data.emailController.clear();
      data.passwordController.clear();
    });
    final formKeyLogIn = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKeyLogIn,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        'https://www.pngitem.com/pimgs/m/111-1114675_user-login-person-man-enter-person-login-icon.png'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        data.validation(value, 'Enter Email Address'),
                    controller: data.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: const Text('Email Id'),
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        data.validation(value, 'Enter Password'),
                    controller: data.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_outlined),
                      label: const Text('Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Consumer<FirebaseAuthLogInProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return value.isLoading
                          ? const CupertinoActivityIndicator(
                              color: Colors.cyan,
                            )
                          : TextButton.icon(
                              onPressed: () async {
                                await data.signInUserAccount(
                                    data.emailController.text,
                                    data.passwordController.text,
                                    context,
                                    formKeyLogIn);
                              },
                              icon: const Icon(Icons.login_outlined),
                              label: const Text('Login'),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 200,
                  ),
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
          ),
        ),
      ),
    );
  }
}
