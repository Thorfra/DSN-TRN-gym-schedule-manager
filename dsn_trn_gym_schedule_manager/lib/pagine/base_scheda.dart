import 'package:dsn_trn_gym_schedule_manager1/pagine/ModificaCampo.dart';
import 'package:flutter/material.dart';
import '../db/esercizio/esercizio.dart';
import '../db/scheda/scheda.dart';
import '../db/dbhelper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      appBar: AppBar(
        title: Text(
          widget.scheda.nomeScheda,
        ),
      ),
      //pulsante aggiunta esercizi
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (contex) {
                  //finestra per l'inserimento
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
                      //pulsanti "aggiungi" e "annulla"
                      ElevatedButton(
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
                            cNomeEsercizio.clear();
                            cRipetizioni.clear();
                            cSerie.clear();
                            cTempoPausa.clear();
                            cCarichi.clear();
                            cAppunti.clear();

                            _dbHelper.createEsercizio(esercizio);

                            setState(() {
                              _esercizi = _dbHelper.getEsercizi();
                            });
                            Navigator.pop(contex);
                          },
                          child: const Text("Aggiungi")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(contex);
                            cNomeEsercizio.clear();
                            cRipetizioni.clear();
                            cSerie.clear();
                            cTempoPausa.clear();
                            cCarichi.clear();
                            cAppunti.clear();
                          },
                          child: const Text("Annulla")),
                    ],
                  );
                });
          }),
      //elenco esercizi
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
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            } else {
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    //funzione elimina e modifica
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          //elimina
                          SlidableAction(
                            onPressed: (_) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Eliminazione Esercizio"),
                                  content: const Text(
                                      "Si desidera davvero eliminare l'esercizio selezionato?"),
                                  icon: const Icon(Icons.delete),
                                  iconColor: Colors.red,
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          _dbHelper.removeEsercizio(
                                              snapshot.data![index].id!);
                                          setState(() {
                                            _esercizi = _dbHelper.getEsercizi();
                                          });
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: Color(0xFF202020),
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                              "Esercizio eliminato!",
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
                          //modifica
                          SlidableAction(
                            onPressed: (_) {
                              AlertDialog(
                                title: const Text("Modifica Esercizio"),
                                content: Column(
                                  children: [
                                    ModificaCampo(
                                        testo:
                                            snapshot.data![index].nomeEsercizio,
                                        controller: cNomeEsercizio)
                                  ],
                                ),
                                //pulsanti aggiungi e annulla
                                actions: [
                                  /*
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
                                        c1.clear();
                                      },
                                      child: const Text("Annulla")),*/
                                ],
                              );
                            },
                            icon: Icons.edit,
                            foregroundColor: Colors.grey,
                            backgroundColor: const Color(0xFF202020),
                            label: "Modifica",
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(right: 15, left: 15),
                        isThreeLine: true,
                        title: Text(
                          snapshot.data![index].nomeEsercizio,
                          style: const TextStyle(fontSize: 19),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].serie} x ${snapshot.data![index].ripetizioni}  \nPausa: ${snapshot.data![index].tempoPausa}$secondi",
                          style: const TextStyle(fontSize: 15),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Carichi",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data![index].carichi
                                            .toString(),
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
                                        snapshot.data![index].appunti
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }
}
