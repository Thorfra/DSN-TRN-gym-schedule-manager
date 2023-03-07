import 'package:flutter/material.dart';

class Elenco_schede extends StatefulWidget {
  const Elenco_schede({super.key});

  @override
  State<Elenco_schede> createState() => _Elenco_schedeState();
}

class _Elenco_schedeState extends State<Elenco_schede> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text("Elenco delle schede presenti"),
        backgroundColor: Colors.black,
      ),
      body: Column(),
    );
  }
}
