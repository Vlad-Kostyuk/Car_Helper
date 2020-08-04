class Inspection {
  int id;
  String nameInspection;
  String descripshon;
  String date;
  int mileage;

  Inspection(this.id, this.nameInspection, this.descripshon, this.date, this.mileage);

  Map<String, dynamic> toMap() {
     final map = Map<String, dynamic>();
     map['id'] = id;
     map['nameInspection'] = nameInspection;
     map['descripshon'] = descripshon;
     map['date'] = date;
     map['mileage'] = mileage;
     return map;
  }

  Inspection.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameInspection = map['nameInspection'];
    descripshon = map['descripshon'];
    date = map['date'];
    mileage = map['mileage'];
  }
}
