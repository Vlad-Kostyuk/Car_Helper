import 'package:carhelper/container.dart';
import 'package:carhelper/db/database.dart';
import 'package:carhelper/model/Inspection.dart';
import 'package:carhelper/page/start_page.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BodyAddInspection extends StatefulWidget {
  const BodyAddInspection({Key key}) : super(key: key);

  @override
  _BodyAddInspectionState createState() => _BodyAddInspectionState();
}

class _BodyAddInspectionState extends State<BodyAddInspection> {
  String selectedDate;
  String dropDownValue = kList[0];
  String nameInspection;
  String descripshon;
  int mileage;

  bool visibilityDropDownValue = false;
  bool visibilityNameInspection = false;
  bool visibilityDescripshon = false;
  bool visibilityMileage = false;
  bool visibilitySelectedDate = false;

  static DateTime now = DateTime.now();
  static int thisYear = (int.parse(DateFormat.y().format(now)) + 1);
  int firstYear = (thisYear - 5);

  Future<List<Inspection>> inspectionList;

  TextEditingController _controllerNameInspection = TextEditingController();
  TextEditingController _controllerDescripshon = TextEditingController();
  TextEditingController _controllerMileage = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    DBProvider.db.databeses;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[


          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                DropdownButton<String>(
                  disabledHint: Text('Виберіть що ви зробили'),
                  value: dropDownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      checkDropDownValue(newValue);
                    });
                  },
                  items: kList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[

                Visibility(
                  visible: visibilityDropDownValue,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextField(
                      obscureText: false,
                      controller: _controllerNameInspection,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name Inspection',
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: visibilityNameInspection,
                  child: Text('Name Inspection is Empty!'),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextField(
                    obscureText: false,
                    controller: _controllerDescripshon,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripshon',
                    ),
                  ),
                ),

                Visibility(
                  visible: visibilityDescripshon,
                  child: Text('Descripshon is Empty!'),
                ),

              ],
            ),
          ),



          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  obscureText: false,
                  controller: _controllerMileage,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mileage: ',
                  ),
                ),

                Visibility(
                  visible: visibilityMileage,
                  child: Text('Mileage is Empty!'),
                ),

                DateField(
                    lastDate: DateTime(thisYear),
                    firstDate: DateTime(firstYear),
                    selectedDate: now,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        selectedDate = date.toString();
                      });
                    }),
              ],
            ),
          ),

          Center(
            child: RaisedButton(
              onPressed: () {
                checkField();
              },
              child: Text('add'),
            ),
          ),

        ],
      ),
    );
  }




  void checkDropDownValue(String newValue) {
    if(dropDownValue.isEmpty) {
      print('dropDownValue is Empty!!!!1');
    } else {
      dropDownValue = newValue;
    }

    if(dropDownValue == kList.last) {
      setState(() {
        visibilityDropDownValue = true;
      });
    } else {
      setState(() {
        visibilityDropDownValue = false;
      });
    }
  }


  bool checkNameInspectionIsEmpty() {
    if(_controllerNameInspection.text.isEmpty) {
      setState(() {
        visibilityNameInspection = true;
      });
      return true;
    } else {
      setState(() {
        visibilityNameInspection = false;
        nameInspection = _controllerNameInspection.text;
      });
      return false;
    }
  }

  bool checkDescripshonIsEmpty() {
    if(_controllerDescripshon.text.isEmpty) {
      setState(() {
        visibilityDescripshon = true;
      });
      return false;
    } else {
      setState(() {
        visibilityDescripshon = false;
        descripshon = _controllerDescripshon.text;
      });
      return true;
    }
  }

  bool checkMileageIsEmpty() {
    if(_controllerMileage.text.isEmpty) {
      setState(() {
        visibilityMileage = true;
      });
      return false;
    } else {
      setState(() {
        visibilityMileage = false;
        mileage = int.parse(_controllerMileage.text);
      });
      return true;
    }
  }


  bool checkValueTitle() {
    if(visibilityDropDownValue == true) {
      checkNameInspectionIsEmpty();
      return true;
    } else {
      print('Error on checkValueTitle');
      return false;
    }
  }

  void checkField() {
    checkValueTitle();
    checkDescripshonIsEmpty();
    checkMileageIsEmpty();

    selectedDate = now.toString();

    if(nameInspection == null && dropDownValue.isNotEmpty) {
      nameInspection = dropDownValue;
    }

    if(!visibilityNameInspection) {
      if(!visibilityDescripshon) {
        if(!visibilityMileage) {

          DBProvider.db.insertInspection(Inspection(null, nameInspection, descripshon, selectedDate, mileage));

          Route route = MaterialPageRoute(builder: (context) => MainPage());
          Navigator.push(context, route);
        }
      }
    }
  }


}
