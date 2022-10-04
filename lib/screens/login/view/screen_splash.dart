import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseaut/screens/dashboard/view/screen_dashboard.dart';
import 'package:firebaseaut/screens/login/controller/authentication_login_provider.dart';
import 'package:firebaseaut/screens/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FirebaseAuthLogInProvider>(context, listen: false);
    return StreamBuilder<User?>(
      stream: data.straem(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const ScreenLogin();
        } else {
          return const ScreenDashBoard();
        }
      },
    );
  }
}
