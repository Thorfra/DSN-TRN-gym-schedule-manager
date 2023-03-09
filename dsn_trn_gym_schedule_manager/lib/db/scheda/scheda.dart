class Scheda {
  final int? id;
  final String nomeScheda;

  Scheda({
    this.id,
    required this.nomeScheda,
  });

  Scheda.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nomeScheda = map["nomeScheda"];

  Map<String, dynamic> toMap() {
    return {"id": id, "nomeScheda": nomeScheda};
  }
}
