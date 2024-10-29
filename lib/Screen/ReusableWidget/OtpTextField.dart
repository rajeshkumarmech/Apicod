import 'package:flutter/material.dart';

class OtpInputField extends StatefulWidget {
  final TextEditingController otpController;
  final int otpLength;
  final String? Function(String?)? validator;

  const OtpInputField({
    super.key,
    required this.otpController,
    this.otpLength = 6,
    this.validator,
  });

  @override
  _OtpInputFieldState createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each text field
    _controllers =
        List.generate(widget.otpLength, (_) => TextEditingController());

    // If there's already some text in the otpController, split it and set it in the respective fields
    if (widget.otpController.text.isNotEmpty) {
      for (int i = 0; i < widget.otpController.text.length; i++) {
        _controllers[i].text = widget.otpController.text[i];
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose(); // Dispose of all individual controllers
    }
    super.dispose();
  }

  // Update the main otpController with the full OTP as the user enters values
  void _updateOtpController() {
    String otp = _controllers.map((controller) => controller.text).join();
    widget.otpController.text = otp;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.otpLength, (index) {
        return SizedBox(
          width: 50, // Adjust width as per your design
          child: TextFormField(
            maxLength: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: _controllers[index],
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.white, // Fills input background with white
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && int.tryParse(value) != null) {
                // Move to the next field when a digit is entered
                if (index < widget.otpLength - 1) {
                  FocusScope.of(context).nextFocus();
                }
              } else if (value.isEmpty && index > 0) {
                // Move to the previous field if cleared
                FocusScope.of(context).previousFocus();
              }

              _updateOtpController(); // Update the full OTP after each input
            },
          ),
        );
      }),
    );
  }
}
