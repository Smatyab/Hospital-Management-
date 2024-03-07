import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonLabel extends StatelessWidget {
  final String displayText;

  const CommonLabel({super.key, required this.displayText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          displayText,
          style: GoogleFonts.alata(
            // Use the same font for consistency
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ));
  }
}
