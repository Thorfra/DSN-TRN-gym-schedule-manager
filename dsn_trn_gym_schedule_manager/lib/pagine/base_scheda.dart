import 'package:flutter/material.dart';
import '../db/esercizio/esercizio.dart';
import '../db/scheda/scheda.dart';
import '../db/dbhelper.dart';

class Base_scheda extends StatefulWidget {
  final Scheda scheda;//questo non funziona
  const Base_scheda({super.key,required this.scheda});
  
  @override
  State<Base_scheda> createState() => Base_schedaState();
}

class Base_schedaState extends State<Base_scheda> {
  late DbHelper _dbHelper;
  Future<List<Esercizio>>? _esercizi;
  Future<List<Scheda>>? _schede;

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
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        title: scheda.nomeScheda,//non vede la variabile che ho passato sopra
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
                    title: const Text("Inserimento esercizio"),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: cNomeEsercizio,
                          decoration:
                              const InputDecoration(hintText: "Nome Esercizio"),
                        ),

                        TextFormField(
                          controller: cRipetizioni,
                          decoration:
                              const InputDecoration(hintText: "Numero Ripetizioni"),
                        ),
                        
                        TextFormField(
                          controller: cSerie,
                          decoration:
                              const InputDecoration(hintText: "Numero Serie"),
                        ),
                        
                        TextFormField(
                          controller: cTempoPausa,
                          decoration:
                              const InputDecoration(hintText: "Secondi di pausa"),
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
                          onPressed: () {
                            Esercizio esercizio = Esercizio(
                              nomeEsercizio: cNomeEsercizio.text,
                              ripetizioni: int.parse(cRipetizioni.text),
                              serie: int.parse(cSerie.text),
                              tempoPausa: int.parse(cTempoPausa.text),
                              idScheda: scheda.id,//non vede l'oggetto
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
                child: Text("Nessun esercizio presente nella scheda"),
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
                  itemBuilder://trovare un modo per visualizzare i dati dell'esercizio
                  /* (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].nomeEsercizio),
                      subtitle: const Text("Clicca per vedere la scheda"),
                      trailing: const Icon(Icons.navigate_next),
                      onTap: ()=> ,
                    );
                  }*/);
            }
          }),
    );
  }
}
