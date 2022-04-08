import 'package:flutter/material.dart';

class SingInText extends StatelessWidget {
  SingInText({required this.textSize,required this.theText});

  final double textSize;
  final String theText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        theText,
        style: TextStyle(
          fontSize: textSize,
          color: const Color(0xFF011627),
          fontWeight: FontWeight.w700,
          fontFamily: 'Karla',
        ),
        // textAlign: TextAlign.center,
      ),
    );
  }
}


