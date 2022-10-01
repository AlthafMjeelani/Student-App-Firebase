import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/screens/login/controller/authentication_login_provider.dart';
import 'package:firebaseaut/screens/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenDashBoard extends StatelessWidget {
  const ScreenDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FirebaseAuthLogInProvider>(context, listen: false);

    return StreamBuilder<User?>(
        stream: data.straem(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const ScreenLogin();
          }
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: TextButton.icon(
                    onPressed: () async {
                      await data.signOutPage(context);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out'),
                  ),
                ),
                Text(FirebaseAuth.instance.currentUser!.uid),
                Text(
                  FirebaseAuth.instance.currentUser!.email.toString(),
                ),
              ],
            ),
          );
        });
  }
}
