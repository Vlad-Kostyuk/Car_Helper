import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BodyAddInspection extends StatefulWidget {
  const BodyAddInspection({Key key}) : super(key: key);

  @override
  _BodyAddInspectionState createState() => _BodyAddInspectionState();
}

class _BodyAddInspectionState extends State<BodyAddInspection> {

  DateTime selectedDate;

  static DateTime now = DateTime.now();
  static int thisYear = (int.parse(DateFormat.y().format(now)) + 1);
  int firstYear = (thisYear - 5);


  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name Inspection',
                    ),
                  ),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripshon',
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[

                 DropdownButton<String>(

                 ),

                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  TextField(
                    obscureText: true,
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
                      onDateSelected: (DateTime date){
                        setState(() {
                          selectedDate = date;
                        });
                      }
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: RaisedButton(
              onPressed: null,
              child: Text(
                'add'
              ),
            )
          ),

        ],
      ),
    );
  }
}

