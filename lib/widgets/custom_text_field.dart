// ignore_for_file: non_constant_identifier_names, must_be_immutable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {super.key,
      required this.onChanged,
      required this.textHint,
      this.Obscure = false});

  String textHint;
  Function(String)? onChanged;
  bool Obscure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: Obscure,
      validator: (data) {
        if (data!.isEmpty) {
          return 'fiald is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: textHint,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
