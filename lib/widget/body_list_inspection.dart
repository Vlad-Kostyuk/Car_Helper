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
    List<Inspection> inspectionListReversed = inspectionList;
    inspectionListReversed = inspectionListReversed.reversed.toList();
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: inspectionListReversed.length,
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
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialogDelete(inspectionListReversed, index);
                }
            ),
            title: Text(inspectionListReversed[index].nameInspection),
            subtitle: Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(inspectionListReversed[index].descripshon),
                  if(inspectionListReversed[index].mileage != 0)
                    Text('Кілометраж: ${inspectionListReversed[index].mileage.toString()} км'),
                  if(inspectionListReversed[index].date != '0')
                   Text(inspectionListReversed[index].date),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Future<void> showDialogDelete(List<Inspection> inspectionList, int index) async {
    return showDialog (
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete this inspection?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You really want to delete this inspection?'
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    DBProvider.db.deleteInspection(
                        inspectionList[index].id);
                    setState(() {
                      updateInspectionList();
                    });
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Canel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

}
