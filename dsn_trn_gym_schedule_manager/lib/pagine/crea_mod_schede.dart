import 'package:flutter/material.dart';
import '../db/scheda/scheda.dart';
import '../db/dbhelper.dart';

class Crea_mod_schede extends StatefulWidget {
  const Crea_mod_schede({super.key});

  @override
  State<Crea_mod_schede> createState() => _Crea_mod_schedeState();
}

class _Crea_mod_schedeState extends State<Crea_mod_schede> {
  late DbHelper _dbHelper;
  Future<List<Scheda>>? _schede;
  TextEditingController c1 = TextEditingController();

  @override
  void initState() {
    super.initState();

    _dbHelper = DbHelper();
    _dbHelper.initializeDb().whenComplete(() async {
      setState(() {
        _schede = _dbHelper.getSchede();
      });
    });
  }

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
            showDialog(
                context: context,
                builder: (contex) {
                  return AlertDialog(
                    title: const Text("Inserimento nuova scheda"),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: c1,
                          decoration:
                              const InputDecoration(hintText: "Nome Scheda"),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            String nome = c1.text;
                            Scheda scheda = Scheda(
                              nomeScheda: nome,
                            );

                            _dbHelper.createScheda(scheda);

                            setState(() {
                              _schede = _dbHelper.getSchede();
                            });
                            Navigator.pop(contex);
                          },
                          child: const Text("Aggiungi")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(contex);
                          },
                          child: const Text("Annulla")),
                    ],
                  );
                });
          }),
      body: FutureBuilder(
          future: _schede,
          builder: (context, AsyncSnapshot<List<Scheda>> snapshot) {
            if (snapshot.data != null && snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Nessuna scheda nel database."),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].nomeScheda),
                      subtitle: const Text("Clicca per vedere la scheda"),
                      trailing: const Icon(Icons.navigate_next),
                    );
                  });
            }
          }),
    );
  }
}
