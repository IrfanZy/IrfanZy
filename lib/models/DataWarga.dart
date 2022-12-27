class DataWarga {
  final String id, nama;

  DataWarga({
    required this.id,
    required this.nama,
  });

  static createNew({
    required id,
    required nama,
  }) =>
      ({
        "id": id,
        "nama": nama,
      });

  static get empty => DataWarga(
        id: "",
        nama: "",
      );

  static DataWarga fetch(
    Function getSnapshot,
  ) =>
      DataWarga(
        id: getSnapshot("id", "").toString(),
        nama: getSnapshot("nama", "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };

  @override
  bool operator ==(other) =>
      other is DataWarga && other.id == id && other.nama == nama;

  @override
  int get hashCode => Object.hash(
        id.hashCode,
        nama.hashCode,
      );
}
