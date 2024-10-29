import 'dart:convert';

import 'package:companyfoxl/Screen/LoginScreen/LoginScreen.dart';
import 'package:companyfoxl/Screen/ReusableWidget/Button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController Resetoldpsdcontroller = TextEditingController();
  TextEditingController Resetnewpsdcontroller = TextEditingController();
  bool value = false;
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$', // At least 8 chars, 1 letter, 1 number
  );

  String? Function(String?) _validateConfirmResetPassword(String newPassword) {
    return (confirmPassword) {
      if (confirmPassword == null || confirmPassword.isEmpty) {
        return 'Please confirm your new password';
      } else if (confirmPassword != newPassword) {
        return 'Passwords do not match';
      }
      return null;
    };
  }

  String? _validateNewResetPassword(String? value) {
    if (value == null) {
      return 'Please enter a new password';
    } else if (!_passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long and include a letter and a number';
    }
    return null;
  }

  Future<void> _submit() async {
    try {
      final response = await http.post(
        Uri.parse("https://chitsoft.in/wapp/api/mobile3/login1.php"),
        body: {
          'type': "59",
          'cid': '11',
          'new_password': Resetoldpsdcontroller.text,
          'cofirm_password': Resetnewpsdcontroller.text
        },
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responsedata = jsonDecode(response.body);
        if (responsedata['error_msg'] == 'Password changed successfully!') {
          // final Map<String, dynamic> user = responsedata['user'];
          print(response.body);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Reset a New Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 26,
                      height: 40.35 / 26,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left, // Aligns text to the left
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter New Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                        controller: Resetoldpsdcontroller,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "New Password",
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
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Conform Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                        obscureText: _isObscure,
                        controller: Resetnewpsdcontroller,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Conform Password",
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xff60778C),
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        validator: _validateConfirmResetPassword(
                            Resetnewpsdcontroller.text),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Mybutton(
                    buttontext: 'SAVE',
                    OnTap: () {
                      _submit();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => OTPScreen()),
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
