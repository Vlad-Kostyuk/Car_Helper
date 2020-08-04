import 'package:carhelper/db/database.dart';
import 'package:carhelper/model/Inspection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyListInspection extends StatefulWidget {
  const BodyListInspection({Key key}) : super(key: key);

  @override
  _BodyListInspectionState createState() => _BodyListInspectionState();
}

class _BodyListInspectionState extends State<BodyListInspection> {
  Future<List<Inspection>> futureInspectionList;

  @override
  void initState() {
    super.initState();
    updateInspectionList();
  }

  updateInspectionList() {
    futureInspectionList = DBProvider.db.getInspection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: futureInspectionList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return list(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text('No Data Found');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget list(List<Inspection> inspectionList) {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: inspectionList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.blueGrey.withOpacity(0.5)),
            ],
          ),
          child: ListTile(
            leading: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  DBProvider.db.deleteInspection(inspectionList[index].id);
                  setState(() {
                    updateInspectionList();
                  });
                }),
            title: Text(inspectionList[index].nameInspection),
            subtitle: Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(inspectionList[index].descripshon),
                  Text(inspectionList[index].mileage.toString()),
                  Text(inspectionList[index].date),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
