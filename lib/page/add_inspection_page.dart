import 'package:carhelper/container.dart';
import 'package:carhelper/widget/center_add_inspection.dart';
import 'package:flutter/material.dart';

class AddInspection extends StatefulWidget {
  const AddInspection({Key key}) : super(key: key);

  @override
  _AddInspectionState createState() => _AddInspectionState();
}

class _AddInspectionState extends State<AddInspection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kTitleAppBarAddInspection,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: BodyAddInspection(),
    );
  }
}
