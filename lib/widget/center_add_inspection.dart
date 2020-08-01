import 'package:carhelper/container.dart';
import 'package:carhelper/db/database.dart';
import 'package:carhelper/model/Inspection.dart';
import 'package:carhelper/page/start_page.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'center_main.dart';

class BodyAddInspection extends StatefulWidget {
  const BodyAddInspection({Key key}) : super(key: key);

  @override
  _BodyAddInspectionState createState() => _BodyAddInspectionState();
}

class _BodyAddInspectionState extends State<BodyAddInspection> {
  DateTime selectedDate;

  String dropDownValue;
  String nameInspection;
  String descripshon;
  int mileage;

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

                Padding(
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

              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                DropdownButton<String>(
                  disabledHint: Text('Виберіть що ви зробили'),
                  value: dropDownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropDownValue = newValue;
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
                TextField(
                  obscureText: false,
                  controller: _controllerMileage,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Km',
                  ),
                ),
                Text(
                  'or',
                ),
                DateField(
                    lastDate: DateTime(thisYear),
                    firstDate: DateTime(firstYear),
                    selectedDate: now,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                      });
                    }),
              ],
            ),
          ),

          Center(
            child: RaisedButton(
              onPressed: () {
                nameInspection = _controllerNameInspection.text;
                descripshon = _controllerDescripshon.text;
                mileage = int.parse(_controllerMileage.text);

                DBProvider.db.insertInspection(Inspection(null, nameInspection, descripshon, mileage));
                Route route = MaterialPageRoute(builder: (context) => MainPage());
                Navigator.push(context, route);

                print(descripshon);
                print(nameInspection);
                print(mileage);
              },
              child: Text('add'),
            ),
          ),

        ],
      ),
    );
  }
}
