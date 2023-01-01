class UserAdmin {
  final String id, pin;

  UserAdmin({
    required this.id,
    required this.pin,
  });

  static get empty => UserAdmin(
        id: "",
        pin: "",
      );

  static UserAdmin fetch(Function getSnapshot) => UserAdmin(
        id: getSnapshot("id", "").toString(),
        pin: getSnapshot("pin", "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pin": pin,
      };

  @override
  bool operator ==(other) =>
      other is UserAdmin && other.id == id && other.pin == pin;

  @override
  int get hashCode => Object.hash(
        id.hashCode,
        pin.hashCode,
      );
}
