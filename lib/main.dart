import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseaut/controller/authentication_login_provider.dart';
import 'package:firebaseaut/controller/authentication_signin_provider.dart';
import 'package:firebaseaut/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirebaseAuthSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseAuthLogInProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenLogin(),
    );
  }
}
