class UserPengurus {
  final String id, pin, name, position, photoUrl;

  UserPengurus({
    required this.id,
    required this.pin,
    required this.name,
    required this.position,
    required this.photoUrl,
  });

  static createNew({
    required pin,
    required name,
    required position,
  }) =>
      ({
        "pin": pin,
        "name": name,
        "position": position,
        "photoUrl": "",
      });

  static get empty => UserPengurus(
        id: "",
        pin: "",
        name: "",
        position: "",
        photoUrl: "",
      );

  static UserPengurus fetch(Function getSnapshot) => UserPengurus(
        id: getSnapshot("id", "").toString(),
        pin: getSnapshot("pin", "").toString(),
        name: getSnapshot("name", "").toString(),
        position: getSnapshot("position", "").toString(),
        photoUrl: getSnapshot("photoUrl", "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pin": pin,
        "name": name,
        "position": position,
        "photoUrl": photoUrl,
      };

  @override
  bool operator ==(other) =>
      other is UserPengurus &&
      other.id == id &&
      other.pin == pin &&
      other.name == name &&
      other.position == position &&
      other.photoUrl == photoUrl;

  @override
  int get hashCode => Object.hash(
        id.hashCode,
        pin.hashCode,
        name.hashCode,
        position.hashCode,
        photoUrl.hashCode,
      );
}
