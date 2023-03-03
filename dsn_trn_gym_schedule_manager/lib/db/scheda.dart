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

  static final String id = '_id';
  static final String nomeEsercizio = 'nome_esercizio';
  static final String ripetizioni = 'ripetizioni';
  static final String serie = 'serie';
  static final String tempoPausa = 'tempo_pausa';
  static final String nomeScheda = 'nome_scheda';
  static final String carichi = 'carichi';
  static final String appunti = 'appunti';
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
/*
  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );*/

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
