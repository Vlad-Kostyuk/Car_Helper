import 'package:carhelper/container.dart';
import 'package:carhelper/widget/body_list_inspection.dart';
import 'package:flutter/material.dart';

class ListInspection extends StatefulWidget {
  const ListInspection({Key key}) : super(key: key);

  @override
  _ListInspectionState createState() => _ListInspectionState();
}

class _ListInspectionState extends State<ListInspection> {
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
      body: BodyListInspection(),
    );
  }
}
