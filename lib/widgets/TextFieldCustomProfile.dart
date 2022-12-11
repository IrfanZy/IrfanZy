// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Textfieldcustomprofile extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool filled;
  final bool readOnly;

  const Textfieldcustomprofile({
    super.key,
    required this.hint,
    this.icon,
    this.filled = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      decoration: InputDecoration(
          filled: filled,
          fillColor: filled ? Colors.white : Colors.transparent,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff3FBDF1),
              width: 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff3FBDF1),
              width: 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
