class DataWarga {
  final String id, name, block, nkk, nik, gender, religion, placeAndDateOfBirth;

  DataWarga({
    required this.id,
    required this.name,
    required this.block,
    required this.nkk,
    required this.nik,
    required this.gender,
    required this.religion,
    required this.placeAndDateOfBirth,
  });

  static createNew({
    required name,
    required block,
    required nkk,
    required nik,
    required gender,
    required religion,
    required placeAndDateOfBirth,
  }) =>
      ({
        "name": name,
        "block": block,
        "nkk": nkk,
        "nik": nik,
        "gender": gender,
        "religion": religion,
        "placeAndDateOfBirth": placeAndDateOfBirth,
      });

  static get empty => DataWarga(
        id: "",
        name: "",
        block: "",
        nkk: "",
        nik: "",
        gender: "",
        religion: "",
        placeAndDateOfBirth: "",
      );

  static DataWarga fetch(Function getSnapshot) => DataWarga(
        id: getSnapshot("id", "").toString(),
        name: getSnapshot("name", "").toString(),
        block: getSnapshot("block", "").toString(),
        nkk: getSnapshot("nkk", "").toString(),
        nik: getSnapshot("nik", "").toString(),
        gender: getSnapshot("gender", "").toString(),
        religion: getSnapshot("religion", "").toString(),
        placeAndDateOfBirth: getSnapshot("placeAndDateOfBirth", "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "block": block,
        "nkk": nkk,
        "nik": nik,
        "gender": gender,
        "religion": religion,
        "placeAndDateOfBirth": placeAndDateOfBirth,
      };

  @override
  bool operator ==(other) =>
      other is DataWarga &&
      other.id == id &&
      other.name == name &&
      other.block == block &&
      other.nkk == nkk &&
      other.nik == nik &&
      other.gender == gender &&
      other.religion == religion &&
      other.placeAndDateOfBirth == placeAndDateOfBirth;

  @override
  int get hashCode => Object.hash(
        id.hashCode,
        name.hashCode,
        block.hashCode,
        nkk.hashCode,
        nik.hashCode,
        gender.hashCode,
        religion.hashCode,
        placeAndDateOfBirth.hashCode,
      );
}
