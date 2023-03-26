class Esercizio {
  final int? id;
  final String nomeEsercizio;
  final int ripetizioni;
  final int serie;
  final int tempoPausa;
  final int? idScheda;
  final String? carichi;
  final String? appunti;

  Esercizio({
    this.id,
    required this.nomeEsercizio,
    required this.ripetizioni,
    required this.serie,
    required this.tempoPausa,
    required this.idScheda,
    this.carichi,
    this.appunti,
  });

  Esercizio.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nomeEsercizio = map["nomeEsercizio"],
        ripetizioni = map["ripetizioni"],
        serie = map["serie"],
        tempoPausa = map["tempoPausa"],
        idScheda = map["idScheda"],
        carichi = map["carichi"],
        appunti = map["appunti"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nomeEsercizio": nomeEsercizio,
      "ripetizioni": ripetizioni,
      "serie": serie,
      "tempoPausa": tempoPausa,
      "idScheda": idScheda,
      "carichi": carichi,
      "appunti": appunti
    };
  }
}
