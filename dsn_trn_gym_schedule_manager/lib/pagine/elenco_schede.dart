import 'package:flutter/material.dart';

class Elenco_schede extends StatelessWidget {
  const Elenco_schede({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Elenco delle schede presenti"),
        backgroundColor: Colors.black,
      ),
      body: Center(),
    );
  }
}
