import 'package:flutter/material.dart';
import '/db/scheda.dart';
import '/db/schede_db.dart';

class Crea_mod_schede extends StatefulWidget {
  const Crea_mod_schede({super.key});

  @override
  State<Crea_mod_schede> createState() => _Crea_mod_schedeState();
}

class _Crea_mod_schedeState extends State<Crea_mod_schede> {
  TextEditingController c1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text("Crea o modifica le schede"),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Nuova_scheda();
          }),
      body: Column(),
    );
  }

  void Nuova_scheda() {
    showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            title: const Text("Inserimento nuova scheda"),
            content: Column(
              children: [
                TextFormField(
                  controller: c1,
                  decoration: const InputDecoration(hintText: "Nome Scheda"),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    /*creare un pulsante con il nome della scheda, che porta ad una pagina dove si possono inserire gli esercizi */
                    Navigator.pop(contex);
                  },
                  child: const Text("Salva")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(contex);
                  },
                  child: const Text("Annulla")),
            ],
          );
        });
  }
}
