import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  const AuthTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "$hintText is missing";
            }
            return null;
          },
        ),
      ],
    );
  }
}