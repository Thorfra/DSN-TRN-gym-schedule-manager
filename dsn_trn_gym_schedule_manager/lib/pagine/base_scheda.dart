import 'package:flutter/material.dart';
import '../db/esercizio/esercizio.dart';
import '../db/scheda/scheda.dart';
import '../db/dbhelper.dart';

class Base_scheda extends StatefulWidget {
  final Scheda scheda;
  const Base_scheda({super.key,required this.scheda});

  @override
  State<Base_scheda> createState() => Base_schedaState();
}

class Base_schedaState extends State<Base_scheda> {
  late DbHelper _dbHelper;
  Future<List<Esercizio>>? _esercizi;
  Future<List<Scheda>>? _schede;

  @override
  void initState() {
    super.initState();

    _dbHelper = DbHelper();
    _dbHelper.initializeDb().whenComplete(() async {
      setState(() {
        _esercizi = _dbHelper.getEsercizi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        title: scheda.nomeScheda,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
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
                      onTap: ()=> ,
                    );
                  });
            }
          }),
    );
  }
}
