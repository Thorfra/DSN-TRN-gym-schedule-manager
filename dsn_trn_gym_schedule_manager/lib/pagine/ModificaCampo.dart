import 'package:flutter/material.dart';

class ModificaCampo extends StatelessWidget {
  const ModificaCampo(
      {super.key, required this.testo, required this.controller});
  final String testo;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: testo,
      controller: controller,
    );
  }
}
