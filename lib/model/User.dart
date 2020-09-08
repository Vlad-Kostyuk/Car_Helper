
class User {
  int id;
  String name;
  int mileage;
  int shotMileage;

  User(this.id, this.name, this.mileage, this.shotMileage);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['mileage'] = mileage;
    map['shotMileage'] = shotMileage;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    mileage = map['mileage'];
    shotMileage = map['shotMileage'];
  }
}