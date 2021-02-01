import 'package:flutter/material.dart';

import '_LoginPageState.dart';
import '_RegistrationPageState.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          // home: MyLoginPage(),
          routes: {
            '/': (BuildContext context) => MyLoginPage(),
            '/registration': (BuildContext context) => MyRegistrationPage()
          },
        );
  }
}
