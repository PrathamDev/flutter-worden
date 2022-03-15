import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
  }) : super(key: key);
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.poppins(
        fontSize: 15,
      ),
      controller: controller,
      cursorHeight: 18,
      cursorColor: Colors.black,
      cursorRadius: const Radius.circular(50),
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          color: Colors.black,
          fontSize: 15,
        ),
        contentPadding:
            const EdgeInsets.only(bottom: 20, right: 15, left: 15, top: 15),
      ),
    );
  }
}
