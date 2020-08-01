class Inspection {
  int id;
  String nameInspection;
  String descripshon;
  int mileage;

  Inspection(this.id, this.nameInspection, this.descripshon, this.mileage);

  Map<String, dynamic> toMap() {
     final map = Map<String, dynamic>();
     map['id'] = id;
     map['nameInspection'] = nameInspection;
     map['descripshon'] = descripshon;
     map['mileage'] = mileage;
     return map;
  }

  Inspection.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameInspection = map['nameInspection'];
    descripshon = map['descripshon'];
    mileage = map['mileage'];
  }
}
