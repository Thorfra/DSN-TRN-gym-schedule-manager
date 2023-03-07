const String table = 'Scheda';

class CampiScheda {
  static final List<String> values = [
    id,
    nomeEsercizio,
    ripetizioni,
    serie,
    tempoPausa,
    nomeScheda,
    carichi,
    appunti
  ];

  static const String id = '_id';
  static const String nomeEsercizio = 'nome_esercizio';
  static const String ripetizioni = 'ripetizioni';
  static const String serie = 'serie';
  static const String tempoPausa = 'tempo_pausa';
  static const String nomeScheda = 'nome_scheda';
  static const String carichi = 'carichi';
  static const String appunti = 'appunti';
}

class Scheda {
  final int? id;
  final String nomeEsercizio;
  final int ripetizioni;
  final int serie;
  final int tempoPausa;
  final String nomeScheda;
  final String? carichi;
  final String? appunti;

  const Scheda({
    this.id,
    required this.nomeEsercizio,
    required this.ripetizioni,
    required this.serie,
    required this.tempoPausa,
    required this.nomeScheda,
    this.carichi,
    this.appunti,
  });

  Scheda copy({
    int? id,
    String? nomeEsercizio,
    int? ripetizioni,
    int? serie,
    int? tempoPausa,
    String? nomeScheda,
    String? carichi,
    String? appunti,
  }) =>
      Scheda(
        id: id ?? this.id,
        nomeEsercizio: nomeEsercizio ?? this.nomeEsercizio,
        ripetizioni: ripetizioni ?? this.ripetizioni,
        serie: serie ?? this.serie,
        tempoPausa: tempoPausa ?? this.tempoPausa,
        nomeScheda: nomeScheda ?? this.nomeScheda,
        carichi: carichi ?? this.carichi,
        appunti: appunti ?? this.appunti,
      );

  static Scheda fromJson(Map<String, Object?> json) => Scheda(
        id: json[CampiScheda.id] as int?,
        nomeEsercizio: json[CampiScheda.nomeEsercizio] as String,
        ripetizioni: json[CampiScheda.ripetizioni] as int,
        serie: json[CampiScheda.serie] as int,
        tempoPausa: json[CampiScheda.tempoPausa] as int,
        nomeScheda: json[CampiScheda.nomeScheda] as String,
        carichi: json[CampiScheda.carichi] as String,
        appunti: json[CampiScheda.appunti] as String,
      );

  Map<String, Object?> toJson() => {
        CampiScheda.id: id,
        CampiScheda.nomeEsercizio: nomeEsercizio,
        CampiScheda.ripetizioni: ripetizioni,
        CampiScheda.serie: serie,
        CampiScheda.tempoPausa: tempoPausa,
        CampiScheda.nomeScheda: nomeScheda,
        CampiScheda.carichi: carichi,
        CampiScheda.appunti: appunti,
      };
}
