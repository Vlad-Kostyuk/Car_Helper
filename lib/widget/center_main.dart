import 'package:carhelper/container.dart';
import 'package:carhelper/db/database.dart';
import 'package:carhelper/model/Inspection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BodyMain extends StatefulWidget {
  const BodyMain({Key key}) : super(key: key);

  @override
  _BodyMainState createState() => _BodyMainState();
}


class _BodyMainState extends State<BodyMain> {
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
      child: Column(
        children: <Widget>[

          Expanded(
            child: Center(
                child: Container(
                  child: Icon(
                    Icons.directions_car,
                    size: 150,
                  ),
                ),
            ),
          ),

          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text('Пройдений кілометраж за місяць: 133 400\n'),
                  Text('Пройдений кілометраж за весь час: $mileageAllTime\n'),
                  Text('Остаіній тех огляд: 13.04.2020 \n'),
                  Text('Наступний тех огляд: 13.04.2020 \n'),
                ],
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: futureInspectionList,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data.length != 0) {
                    return list(snapshot.data);
                  }
                }
                if(snapshot.data == null || snapshot.data.length == 0) {
                  return Text('List Inspection is Empty :(');
                }
                return CircularProgressIndicator();
              },
            ),
          ),


        ],
      ),
    );
  }

  Widget list(List<Inspection> inspectionList) {
    allTime(inspectionList);
      return  ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow:[ BoxShadow(
                color: Colors.blueGrey.withOpacity(0.5)
              ),
             ],
            ),
            child: ListTile(
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialogDelete(inspectionList, inspectionList.length - 1);
                  }
              ),
              title: Text(inspectionList[inspectionList.length - 1].nameInspection),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(inspectionList[inspectionList.length - 1].descripshon),
                    if(inspectionList[inspectionList.length - 1].mileage != 0)
                      Text('Кілометраж: ${inspectionList[inspectionList.length - 1].mileage.toString()} км'),
                    if(inspectionList[inspectionList.length - 1].date != '0')
                     Text(inspectionList[inspectionList.length - 1].date),
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
                      allTime(inspectionList);
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


  void allTime(List<Inspection> inspectionList) {
    if(inspectionList.isNotEmpty) {
      for (int tmp = 0; tmp < inspectionList.length; tmp++) {
          mileageAllTime = 0;
          mileageAllTime = mileageAllTime + inspectionList[tmp].mileage;
      }
    }
  }

}

