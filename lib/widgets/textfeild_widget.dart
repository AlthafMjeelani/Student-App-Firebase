import 'package:flutter/material.dart';

class Textfeildwidget extends StatelessWidget {
  const Textfeildwidget({
    Key? key,
    required this.validator,
    required this.text,
    required this.icon,
    required this.controller,
    this.keyboardType,
    required this.readOnly,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final String text;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
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
