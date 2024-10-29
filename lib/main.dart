import 'package:companyfoxl/Chits/Profile.dart';
import 'package:companyfoxl/Chits/chits.dart';
import 'package:companyfoxl/Screen/LoginScreen/CreateNewPassword.dart';
import 'package:companyfoxl/Screen/LoginScreen/LoginScreen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: //ResetPasswordScreen()
          LoginScreen(),
    );
  }
}
