import 'package:flutter/material.dart';

class TextFieldCustomProfile extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String hint;
  final bool filled;
  final bool readOnly;

  const TextFieldCustomProfile({
    super.key,
    required this.controller,
    this.icon,
    this.hint = "",
    this.filled = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
