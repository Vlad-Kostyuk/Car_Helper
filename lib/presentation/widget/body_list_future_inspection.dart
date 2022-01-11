import 'package:carhelper/data/db/database.dart';
import 'package:carhelper/data/model/Inspection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyListInspectionFuture extends StatefulWidget {
  const BodyListInspectionFuture({Key key}) : super(key: key);

  @override
  _BodyListInspectionFutureState createState() => _BodyListInspectionFutureState();
}

class _BodyListInspectionFutureState extends State<BodyListInspectionFuture> {
  Future<List<Inspection>> futureInspectionList;
  Future<List<Inspection>> inspectionList;

  @override
  void initState() {
    super.initState();
    updateInspectionList();
  }

  updateInspectionList() {
    futureInspectionList = DBProvider.db.getFutureInspection();
    inspectionList = DBProvider.db.getInspection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Future.wait([futureInspectionList, inspectionList]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return list(snapshot.data[0], snapshot.data[1]);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text('No Data Found');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget list(List<Inspection> futureInspectionList, List<Inspection> inspectionList) {
    List<Inspection> inspectionListReversed;
    inspectionListReversed = futureInspectionList + inspectionList;
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
              if(inspectionListReversed[index].color == 'blue')
              BoxShadow(color: Colors.blue),
              if(inspectionListReversed[index].color == 'green')
                BoxShadow(color: Colors.green),
            ],
          ),
          child: ListTile(
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialogDelete(inspectionListReversed, index, inspectionListReversed.length);
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
                    if(inspectionListReversed[index].color == 'blue')
                     Text('Запланований кілометраж: ${inspectionListReversed[index].mileage.toString()} км'),
                    if(inspectionListReversed[index].color == 'green')
                     Text('Пройдений кілометраж: ${inspectionListReversed[index].mileage.toString()} км'),
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


  Future<void> showDialogDelete(List<Inspection> inspectionListReversed, int index, int length) async {
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

                    if(index >= length/2) {
                      DBProvider.db.deleteFutureInspection(inspectionListReversed[index].id);
                      setState(() {
                        updateInspectionList();
                      });
                    } else {
                      DBProvider.db.deleteInspection(inspectionListReversed[index].id);
                      setState(() {
                        updateInspectionList();
                      });
                    }
                    if(length == 1) {
                      ///дуже великий колстиль
                      DBProvider.db.deleteInspection(inspectionListReversed[index].id);
                      DBProvider.db.deleteFutureInspection(inspectionListReversed[index].id);
                      setState(() {
                        updateInspectionList();
                      });
                    }

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
