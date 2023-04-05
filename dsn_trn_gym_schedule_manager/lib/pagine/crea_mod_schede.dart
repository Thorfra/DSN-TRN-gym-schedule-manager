import 'package:flutter/material.dart';
import '../db/scheda/scheda.dart';
import '../db/dbhelper.dart';
import 'base_scheda.dart';

class CreaModSchede extends StatefulWidget {
  const CreaModSchede({super.key});

  @override
  State<CreaModSchede> createState() => _CreaModSchedeState();
}

class _CreaModSchedeState extends State<CreaModSchede> {
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
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        title: const Text("Crea o modifica le schede"),
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
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
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
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) =>
                                (BaseScheda(scheda: snapshot.data![index])))));
                      },
                    );
                  });
            }
          }),
    );
  }
}
