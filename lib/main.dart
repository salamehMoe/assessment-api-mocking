import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_mockup/registration_screen.dart';
import 'home-page.dart';
import 'login-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginPage.id: (context) => LoginPage(),
      },
    );
  }
}


