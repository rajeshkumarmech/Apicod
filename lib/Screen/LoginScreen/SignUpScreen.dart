import 'dart:convert';

import 'package:companyfoxl/Screen/LoginScreen/LoginScreen.dart';
import 'package:companyfoxl/Screen/LoginScreen/OTPScreen.dart';
import 'package:companyfoxl/Screen/ReusableWidget/Button.dart';
import 'package:companyfoxl/Screen/ReusableWidget/GoogleSigninButton.dart';
import 'package:companyfoxl/Screen/ReusableWidget/InputTextField.dart';
import 'package:companyfoxl/Screen/ReusableWidget/TextButton.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController regmobilecontroller = TextEditingController();
  TextEditingController regnamecontroller = TextEditingController();
  TextEditingController regemailcontroller = TextEditingController();

  bool value = false;
  final _formKey = GlobalKey<FormState>();

  final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  final RegExp _phoneRegExp = RegExp(
    r'^[0-9]\d{9}$',
  );

  // // Validation function
  String? _validateReg(String value) {
    if (value.isEmpty) {
      return 'Please enter an E-mail';
      // } else if (_phoneRegExp.hasMatch(value)) {
      //   if (value.length != 10) {
      //     return 'Phone number must be exactly 10 digits';
      //   }
    } else if (!_emailRegExp.hasMatch(value)) {
      return 'Please enter a valid Email';
    }
    return null;
  }

  Future<void> _Rsubmit() async {
    try {
      final response = await http.post(
        Uri.parse("https://chitsoft.in/wapp/api/mobile3/login1.php"),
        body: {
          'type': "55",
          'cid': '11',
          'name': regnamecontroller.text,
          'email': regemailcontroller.text,
          'phone_number': regmobilecontroller.text,
        },
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responsedata = jsonDecode(response.body);
        if (responsedata['error'] == false) {
          // final Map<String, dynamic> user = responsedata['user'];
          print(response.body);

          // print("Name: ${user['Name']}");
          // print("Mobile: ${user['Phone_number']}");
          // print("Email: ${user['Email']}");
          // print("Password: ${user['Password']}");
          // print("User_id: ${user['User_id']}");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OTPScreen()),
          );
        } else {
          print('Error: ${responsedata['error_msg']}');
        }
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/LoginpageBGimage.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: -screenHeight * 0.04,
            right: -screenWidth * 0.05,
            child: CircleAvatar(
              radius: screenWidth * 0.24,
              backgroundImage: const AssetImage('images/Circle.png'),
            ),
          ),
          Positioned(
            top: screenHeight * 0.01,
            right: screenWidth * 0.02,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: screenWidth * 0.18,
              backgroundImage: const AssetImage('images/FOXL Logo.png'),
            ),
          ),
          Positioned(
            top: screenHeight * 0.2,
            right: -screenWidth * 0.04,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Create a New Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 26,
                      height: 40.35 / 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: SizedBox(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.1,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: TextFormField(
                        controller: regnamecontroller,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Name",
                          hintStyle: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(221, 138, 136, 136)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Enter user name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'E-Mail',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: SizedBox(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.1,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: TextFormField(
                        controller: regemailcontroller,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "E-mail",
                          hintStyle: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(221, 138, 136, 136)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mobile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: regmobilecontroller,
                        decoration: InputDecoration(
                          hintText: "Mobile",
                          hintStyle: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(221, 138, 136, 136)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return ' Enter your mobile number';
                            // } else if (!RegExp(
                            //         r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            //     .hasMatch(value)) {
                            //   return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Mybutton(
                    buttontext: 'REGISTER',
                    OnTap: () {
                      _Rsubmit();
                    },
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        height: 0.5,
                        color: const Color(0xff514B6B),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Or',
                        style: TextStyle(
                          color: Color(0xff514B6B),
                          fontSize: 12,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: screenWidth * 0.5,
                        height: 0.5,
                        color: const Color(0xff514B6B),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  GoogleSigninButton(
                    Googletext: 'Sign in with Google',
                    imagePath: 'images/GoogleImage.png',
                    GoogleSignin: () {},
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextButtonUser(
                    textreg: 'Sign in',
                    newbuttonregister: () {},
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
