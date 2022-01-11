
class Inspection {
  int id;
  String nameInspection;
  String descripshon;
  String date;
  int mileage;
  String color;

  Inspection(this.id, this.nameInspection, this.descripshon, this.date, this.mileage, this.color);

  Map<String, dynamic> toMap() {
     final map = Map<String, dynamic>();
     map['id'] = id;
     map['nameInspection'] = nameInspection;
     map['descripshon'] = descripshon;
     map['date'] = date;
     map['mileage'] = mileage;
     map['color'] = color;
     return map;
  }

  Inspection.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameInspection = map['nameInspection'];
    descripshon = map['descripshon'];
    date = map['date'];
    mileage = map['mileage'];
    color = map['color'];
  }
}
