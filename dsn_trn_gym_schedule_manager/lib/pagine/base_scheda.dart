import 'package:flutter/material.dart';
import '../db/esercizio/esercizio.dart';
import '../db/scheda/scheda.dart';
import '../db/dbhelper.dart';

class BaseScheda extends StatefulWidget {
  final Scheda scheda;
  const BaseScheda({super.key, required this.scheda});

  @override
  State<BaseScheda> createState() => BaseSchedaState();
}

class BaseSchedaState extends State<BaseScheda> {
  late DbHelper _dbHelper;
  Future<List<Esercizio>>? _esercizi;

  TextEditingController cNomeEsercizio = TextEditingController();
  TextEditingController cRipetizioni = TextEditingController();
  TextEditingController cSerie = TextEditingController();
  TextEditingController cTempoPausa = TextEditingController();
  TextEditingController cCarichi = TextEditingController();
  TextEditingController cAppunti = TextEditingController();

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
    const String secondi = '"';
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          widget.scheda.nomeScheda,
        ),
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
                    scrollable: true,
                    title: const Text("Inserimento esercizio"),
                    content: Column(
                      children: [
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: cNomeEsercizio,
                          decoration:
                              const InputDecoration(hintText: "Nome Esercizio"),
                        ),
                        TextFormField(
                          controller: cRipetizioni,
                          decoration: const InputDecoration(
                              hintText: "Numero Ripetizioni"),
                        ),
                        TextFormField(
                          controller: cSerie,
                          decoration:
                              const InputDecoration(hintText: "Numero Serie"),
                        ),
                        TextFormField(
                          controller: cTempoPausa,
                          decoration: const InputDecoration(
                              hintText: "Secondi di pausa"),
                        ),
                        TextFormField(
                          controller: cCarichi,
                          decoration:
                              const InputDecoration(hintText: "Carichi"),
                        ),
                        TextFormField(
                          controller: cAppunti,
                          decoration:
                              const InputDecoration(hintText: "Appunti"),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            Esercizio esercizio = Esercizio(
                              nomeEsercizio: cNomeEsercizio.text,
                              ripetizioni: int.parse(cRipetizioni.text),
                              serie: int.parse(cSerie.text),
                              tempoPausa: int.parse(cTempoPausa.text),
                              idScheda: widget.scheda.id,
                              carichi: cCarichi.text,
                              appunti: cAppunti.text,
                            );

                            _dbHelper.createEsercizio(esercizio);

                            setState(() {
                              _esercizi = _dbHelper.getEsercizi();
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
          future: _esercizi,
          builder: (context, AsyncSnapshot<List<Esercizio>> snapshot) {
            if (snapshot.data != null && snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Nessun esercizio presente nella scheda",
                  style: TextStyle(fontSize: 17),
                ),
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
                      contentPadding:
                          const EdgeInsets.only(right: 15, left: 15),
                      isThreeLine: true,
                      title: Text(
                        snapshot.data![index].nomeEsercizio,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 19),
                      ),
                      subtitle: Text(
                        "${snapshot.data![index].serie} x ${snapshot.data![index].ripetizioni}  \nPausa: ${snapshot.data![index].tempoPausa}$secondi",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      trailing: const Icon(Icons.navigate_next),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                scrollable: true,
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Carichi",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data![index].carichi.toString(),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      "Appunti",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data![index].appunti.toString(),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    );
                  });
            }
          }),
    );
  }
}
