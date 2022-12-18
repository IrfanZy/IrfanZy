// ignore_for_file: file_names

class WargaModel {
  final String nama, nik, password;

  WargaModel({
    required this.nama,
    required this.nik,
    required this.password,
  });

  static get empty => WargaModel(
        nama: "",
        nik: "",
        password: "",
      );

  static WargaModel fetch(
    Function getSnapshot,
  ) =>
      WargaModel(
        nama: getSnapshot("nama", "").toString(),
        nik: getSnapshot("nik", "").toString(),
        password: getSnapshot("password", "").toString(),
      );

  @override
  bool operator ==(other) =>
      other is WargaModel &&
      other.nama == nama &&
      other.nik == nik &&
      other.password == password;

  @override
  int get hashCode => Object.hash(
        nama.hashCode,
        nik.hashCode,
        password.hashCode,
      );
}
