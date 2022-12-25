// ignore_for_file: file_names

class WargaModel {
  final String name, nik, password, address, phoneNumber;

  WargaModel({
    required this.name,
    required this.nik,
    required this.password,
    required this.address,
    required this.phoneNumber,
  });

  static get empty => WargaModel(
        name: "",
        nik: "",
        password: "",
        address: "",
        phoneNumber: "",
      );

  static WargaModel fetch(
    Function getSnapshot,
  ) =>
      WargaModel(
        name: getSnapshot("name", "").toString(),
        nik: getSnapshot("nik", "").toString(),
        password: getSnapshot("password", "").toString(),
        address: getSnapshot("address", "").toString(),
        phoneNumber: getSnapshot("phoneNumber", "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nik": nik,
        "password": password,
        "address": address,
        "phoneNumber": phoneNumber,
      };

  @override
  bool operator ==(other) =>
      other is WargaModel &&
      other.name == name &&
      other.nik == nik &&
      other.password == password &&
      other.address == address &&
      other.phoneNumber == phoneNumber;

  @override
  int get hashCode => Object.hash(
        name.hashCode,
        nik.hashCode,
        password.hashCode,
        address.hashCode,
        phoneNumber.hashCode,
      );
}
