import 'package:flutter/material.dart';

class FieldForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  bool? isForm = true;

  FieldForm({
    required this.label,
    required this.controller,
    this.isForm,
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: this.isForm,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        labelText: label,
       ),
    );
  }
}
