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
  static final int id;
  static final String nome_esercizio;
  static final int ripetizioni;
  static final int serie;
  static final int tempo_pausa;
  static final String nome_scheda;
  static final String carichi;
  static final String appunti;

/*
  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };*/
}
