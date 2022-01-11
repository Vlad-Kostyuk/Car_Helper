import 'package:carhelper/string/container.dart';
import 'package:carhelper/presentation/widget/center_add_future_inspection.dart';
import 'package:flutter/material.dart';

class AddFutureInspection extends StatefulWidget {
  const AddFutureInspection({Key key}) : super(key: key);

  @override
  _AddFutureInspectionState createState() => _AddFutureInspectionState();
}

class _AddFutureInspectionState extends State<AddFutureInspection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kTitleAppBarAddInspectionFuture,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: ListView(
        children: <Widget>[
          BodyAddFutureInspection(),
        ],
      ),
    );
  }
}
