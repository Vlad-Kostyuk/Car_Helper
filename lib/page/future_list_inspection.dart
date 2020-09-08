import 'package:carhelper/container.dart';
import 'package:carhelper/widget/body_list_future_inspection.dart';
import 'package:flutter/material.dart';

class ListInspectionFuture extends StatefulWidget {
  const ListInspectionFuture({Key key}) : super(key: key);

  @override
  _ListInspectionFutureState createState() => _ListInspectionFutureState();
}

class _ListInspectionFutureState extends State<ListInspectionFuture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kTitleAppBarListInspectionFuture,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: BodyListInspectionFuture(),
    );
  }
}
