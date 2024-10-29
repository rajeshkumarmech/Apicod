import 'package:flutter/material.dart';

class TextButtonUser extends StatelessWidget {
  final String textreg;
  final VoidCallback? newbuttonregister;
  const TextButtonUser(
      {super.key, required this.textreg, this.newbuttonregister});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "you don't have an account?",
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: newbuttonregister,
          child: Text(
            textreg,
            style: const TextStyle(
              fontSize: 15,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
