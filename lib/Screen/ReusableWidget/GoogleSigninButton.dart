import 'package:flutter/material.dart';

class GoogleSigninButton extends StatelessWidget {
  final String Googletext;
  final VoidCallback? GoogleSignin;
  final String imagePath;
  const GoogleSigninButton(
      {super.key,
      required this.Googletext,
      this.GoogleSignin,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: GoogleSignin,
      child: Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 45,
                child: Image.asset(imagePath),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                Googletext,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF6C7174)),
              )
            ],
          )),
    );
  }
}
