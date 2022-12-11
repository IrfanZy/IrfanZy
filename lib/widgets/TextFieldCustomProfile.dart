import 'package:flutter/material.dart';

class Textfieldcustomprofile extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool filled;

  const Textfieldcustomprofile({
    super.key,
    required this.hint,
    this.icon,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
