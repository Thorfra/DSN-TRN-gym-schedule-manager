const String table = 'Scheda';

class Scheda {
  final int? id;
  final String nomeEsercizio;
  final int ripetizioni;
  final int serie;
  final int tempoPausa;
  final String nomeScheda;
  final String? carichi;
  final String? appunti;

  Scheda({
    this.id,
    required this.nomeEsercizio,
    required this.ripetizioni,
    required this.serie,
    required this.tempoPausa,
    required this.nomeScheda,
    this.carichi,
    this.appunti,
  });

  Scheda.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nomeEsercizio = map["nomeEsercizio"],
        ripetizioni = map["ripetizioni"],
        serie = map["serie"],
        tempoPausa = map["tempoPausa"],
        nomeScheda = map["nomeScheda"],
        carichi = map["carichi"],
        appunti = map["appunti"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nomeEsercizio": nomeEsercizio,
      "ripetizioni": ripetizioni,
      "serie": serie,
      "tempoPausa": tempoPausa,
      "nomeScheda": nomeScheda,
      "carichi": carichi,
      "appunti": appunti
    };
  }
}
