import 'package:flutter/material.dart';

class Textfeildwidget extends StatelessWidget {
  const Textfeildwidget({
    Key? key,
    required this.validator,
    required this.text,
    required this.icon,
    required this.controller,
    this.keyboardType,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final String text;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        label: Text(text),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
