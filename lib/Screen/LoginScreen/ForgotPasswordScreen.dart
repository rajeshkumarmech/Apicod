import 'dart:convert';

import 'package:companyfoxl/Screen/LoginScreen/OtpForgotPassword.dart';
import 'package:companyfoxl/Screen/ReusableWidget/Button.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController Forgotemailidcontroller = TextEditingController();

  bool value = false;
  final _formKey = GlobalKey<FormState>();

  // Regular expression for email validation
  final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Regular expression for phone number validation (10 digits, starting with [6-9])
  final RegExp _phoneRegExp = RegExp(
    r'^[0-9]\d{9}$',
  );

  // Validation function
  String? _validateForgot(String value) {
    if (value.isEmpty) {
      return 'Please enter an email or phone number';
    } else if (_phoneRegExp.hasMatch(value)) {
      if (value.length != 10) {
        return 'Phone number must be exactly 10 digits';
      }
    } else if (!_emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email or phone number';
    }
    return null;
  }

  Future<void> _Forgotsubmit() async {
    try {
      final response = await http.post(
        Uri.parse("https://chitsoft.in/wapp/api/mobile3/login1.php"),
        body: {
          'type': "57",
          'cid': '11',
          'email': Forgotemailidcontroller.text,
          'phone_number': Forgotemailidcontroller.text
        },
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responsedata = jsonDecode(response.body);
        if (responsedata['error_msg'] == 'Otp has been sent successfully') {
          // final Map<String, dynamic> user = responsedata['user'];
          print(response.body);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const OTPForgotPasswordScreen()),
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

    // if (_formKey.currentState?.validate() == true) {
    //   Forgotemailidcontroller.text = '';

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const OTPForgotPasswordScreen()),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text(
    //         'Please enter a valid user ID and password',
    //       ),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
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
            backgroundColor: const Color.fromARGB(255, 36, 63, 121),
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
          top: screenHeight * 0.20,
          right: screenWidth * 0.045,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Forgot Password ',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 26,
                    height: 40.35 / 26,
                    fontWeight: FontWeight.w700,
                  ),
                  // Aligns text to the left
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Please Enter Your Email or Mobile Number',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'To Receive a Verification Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email/Mobile number',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(height: screenHeight * 0.02),
                // SizedBox(
                //   width: screenWidth * 0.9,
                //   child: InputTextField(
                //     hint: 'autochit@gmail.com',
                //     controller: Forgotemailidcontroller,
                //     validator: (value) =>
                //         _validateForgot(Forgotemailidcontroller.text),
                //   ),
                // ),
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
                      controller: Forgotemailidcontroller,
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
                      validator: (value) =>
                          _validateForgot(Forgotemailidcontroller.text),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Mybutton(
                  buttontext: 'SEND OTP',
                  OnTap: () {
                    _Forgotsubmit();
                  },
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
