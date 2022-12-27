class UserWarga {
  final String id, name, nik, email, address, phoneNumber;

  UserWarga({
    required this.id,
    required this.name,
    required this.nik,
    required this.email,
    required this.address,
    required this.phoneNumber,
  });

  static createNew({
    required name,
    required nik,
    required email,
    required address,
    required phoneNumber,
  }) =>
      ({
        "name": name,
        "nik": nik,
        "email": email,
        "address": address,
        "phoneNumber": phoneNumber,
      });

  static get empty => UserWarga(
        id: "",
        name: "",
        nik: "",
        email: "",
        address: "",
        phoneNumber: "",
      );

  static UserWarga fetch(
    Function getSnapshot,
  ) =>
      UserWarga(
        id: getSnapshot("id", "").toString(),
        name: getSnapshot("name", "").toString(),
        nik: getSnapshot("nik", "").toString(),
        email: getSnapshot("email", "").toString(),
        address: getSnapshot("address", "").toString(),
        phoneNumber: getSnapshot("phoneNumber", "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "address": address,
        "phoneNumber": phoneNumber,
      };

  @override
  bool operator ==(other) =>
      other is UserWarga &&
      other.id == id &&
      other.name == name &&
      other.nik == nik &&
      other.email == email &&
      other.address == address &&
      other.phoneNumber == phoneNumber;

  @override
  int get hashCode => Object.hash(
        id.hashCode,
        name.hashCode,
        nik.hashCode,
        email.hashCode,
        address.hashCode,
        phoneNumber.hashCode,
      );
}
