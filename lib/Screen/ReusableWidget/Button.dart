import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String buttontext;
  final VoidCallback? OnTap;
  const Mybutton({super.key, required this.buttontext, this.OnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: TextButton(
            onPressed: OnTap,
            child: Text(
              buttontext,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1),
            )));
  }
}
