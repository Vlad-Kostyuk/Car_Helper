import 'package:flutter/material.dart';

class BodyAddInspection extends StatefulWidget {
  const BodyAddInspection({Key key}) : super(key: key);

  @override
  _BodyAddInspectionState createState() => _BodyAddInspectionState();
}

class _BodyAddInspectionState extends State<BodyAddInspection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),

          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),

          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),

        ],
      ),
    );
  }
}

