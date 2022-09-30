import 'package:firebaseaut/controller/authentication_signin_provider.dart';
import 'package:firebaseaut/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenDashBoard extends StatelessWidget {
  const ScreenDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<FirebaseAuthSignInProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FirebaseAuthSignInProvider>(
        builder: (BuildContext context, FirebaseAuthSignInProvider value,
            Widget? child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    data.signOutPage();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => ScreenLogin(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                ),
              ),
              Text(value.user!.uid),
              Text(
                value.user!.email.toString(),
              ),
            ],
          );
        },
      ),
    );
  }
}
