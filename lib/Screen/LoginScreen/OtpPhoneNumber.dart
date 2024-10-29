import 'dart:async';
import 'dart:convert';
import 'package:companyfoxl/Screen/LoginScreen/LoginScreen.dart';
import 'package:companyfoxl/Screen/ReusableWidget/Button.dart';
import 'package:companyfoxl/Screen/ReusableWidget/OtpTextField.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

class PhoneOTPScreen extends StatefulWidget {
  final String phoneNumber;
  const PhoneOTPScreen({super.key, required this.phoneNumber});

  @override
  State<PhoneOTPScreen> createState() => _PhoneOTPScreenState();
}

class _PhoneOTPScreenState extends State<PhoneOTPScreen> {
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _timerSeconds = 30;
  int _resendCount = 0;
  bool _canResend = false;
  Timer? _timer;
  bool _isLoading = false;
  String? _otpCode;

  @override
  void initState() {
    super.initState();
    // listenForCode();
    startTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    _timer?.cancel();

    super.dispose();
  }

  // Function to validate OTP input
  String? _validateOtp(String? value) {
    if (value == null) {
      return 'Please enter the OTP';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits long';
    }
    return null;
  }

  final String _baseUrl = 'https://chitsoft.in/wapp/api/mobile2/index.php';

  Future<void> verifyOtp(String phoneNumber, String otp) async {
    if (_validateOtp(otp) != null) {
      _showSnackbar(
        'Enter an OTP',
        const Color.fromARGB(255, 179, 104, 214),
      );
    }
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(_baseUrl);
    final response = await http.post(url, body: {
      'type': '3',
      'cid': '21472147',
      'id': '567',
      'mobile': phoneNumber,
      'otp': otp,
    });

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is Map<String, dynamic>) {
        if (responseData.containsKey('error') &&
            responseData['error'] == true) {
          var errorMessage = responseData['error_msg'];

          if (errorMessage is String &&
              errorMessage.toLowerCase().contains('invalid otp')) {
            _showSnackbar('Invalid OTP. Please try again.', Colors.red);
          } else if (errorMessage is String) {
            _showSnackbar(errorMessage, Colors.red);
          } else {
            _showSnackbar('Invalid OTP. Please try again.', Colors.red);
          }
        } else {
          _showSnackbar('OTP verified successfully', Colors.green);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } else {
        _showSnackbar('Unexpected response from the server.', Colors.red);
      }
    } else {
      _showSnackbar('Failed to verify OTP. Please try again.', Colors.red);
      print('Failed to verify OTP: ${response.statusCode}');
    }
  }

  // Resend OTP functionality
  Future<void> resendOtp(String phoneNumber) async {
    setState(() {
      if (_resendCount < 3) {
        setState(() {
          _resendCount++;
          startTimer();
        });
      }
      _isLoading = true;
    });

    final url = Uri.parse(_baseUrl);
    final response = await http.post(url, body: {
      'type': '2',
      'cid': '21472147',
      'id': '567',
      'mobile': phoneNumber,
    });

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is Map<String, dynamic> &&
          responseData['error'] != true) {
        _showSnackbar('OTP resent successfully', Colors.green);
      } else {
        _showSnackbar('Failed to resend OTP. Try again later.', Colors.red);
      }
    } else {
      _showSnackbar('Server error while resending OTP.', Colors.red);
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // @override
  // void codeUpdated() {
  //   setState(() {
  //     _otpCode = code;
  //     otpController.text = _otpCode ?? '';
  //   });
  // }

  void startTimer() {
    _timerSeconds = 30;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_timerSeconds == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _timerSeconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                  children: [
                    const Text(
                      'Enter OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 26,
                        height: 40.35 / 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    const Text(
                      'Please Enter The 6 Digit Code Sent to',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      widget.phoneNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.9,
                          child: OtpInputField(
                            otpController: otpController,
                            otpLength: 6,
                            validator: _validateOtp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      children: [
                        if (_resendCount < 3)
                          GestureDetector(
                            onTap: _canResend
                                ? () async {
                                    await resendOtp(widget.phoneNumber);
                                  }
                                : null,
                            child: Text(
                              _canResend
                                  ? 'Resend Code'
                                  : 'Resend in $_timerSeconds s',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            print('Opening WhatsApp...');
                          },
                          child: const Text(
                            "WhatsApp's",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Mybutton(
                            buttontext: 'VERIFY',
                            OnTap: () async {
                              if (_formKey.currentState?.validate() ?? true) {
                                await verifyOtp(
                                    widget.phoneNumber, otpController.text);
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
