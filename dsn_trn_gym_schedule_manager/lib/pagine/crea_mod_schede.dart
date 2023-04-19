import 'package:flutter/material.dart';
import '../db/scheda/scheda.dart';
import '../db/dbhelper.dart';
import 'base_scheda.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      appBar: AppBar(
        title: const Text("Crea o modifica le schede"),
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
                            c1.clear();
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
                child: Text(
                  "Nessuna scheda nel database.",
                  style: TextStyle(fontSize: 17),
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Eliminazione Scheda"),
                                  content: const Text(
                                      "Si desidera davvero eliminare la scheda selezionata?"),
                                  icon: const Icon(Icons.delete),
                                  iconColor: Colors.red,
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          _dbHelper.removeScheda(
                                              snapshot.data![index].id!);
                                          setState(() {
                                            _schede = _dbHelper.getSchede();
                                          });
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: Color(0xFF202020),
                                            duration: Duration(
                                                seconds: 1, milliseconds: 5),
                                            content: Text(
                                              "Scheda eliminata!",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ));
                                        },
                                        child: const Text("Sì")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No")),
                                  ],
                                ),
                              );
                            },
                            icon: Icons.delete,
                            foregroundColor: Colors.red,
                            backgroundColor: const Color(0xFF202020),
                            label: "Elimina",
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(snapshot.data![index].nomeScheda),
                        subtitle: const Text("Clicca per vedere la scheda"),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => (BaseScheda(
                                  scheda: snapshot.data![index])))));
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }
}
