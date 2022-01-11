import 'package:carhelper/string/container.dart';
import 'package:carhelper/data/db/database.dart';
import 'package:carhelper/data/model/Inspection.dart';
import 'package:carhelper/data/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BodyMain extends StatefulWidget {
  const BodyMain({Key key}) : super(key: key);

  @override
  _BodyMainState createState() => _BodyMainState();
}


class _BodyMainState extends State<BodyMain> {
  Future<List<Inspection>> oldInspectionList;
  Future<List<User>> futureUser;
  Future<List<Inspection>> futureInspectionList;

  int mileageAllTime;



  @override
  void initState() {
    super.initState();
    updateInspectionList();
  }

  updateInspectionList() {
    oldInspectionList = DBProvider.db.getInspection();
    futureInspectionList = DBProvider.db.getFutureInspection();
    futureUser = DBProvider.db.getUser();
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
            child: FutureBuilder(
              future: Future.wait([futureUser, oldInspectionList, futureInspectionList]),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data[0].length != 0 && snapshot.data[1].length != 0 && snapshot.data[2].length != 0) {
                    return listInfo(snapshot.data[0], snapshot.data[1], snapshot.data[2]);
                  }
                }
                if(snapshot.data == null || snapshot.data.length == 0) {
                  return Text('List Inspection is Empty :(');
                }
                return CircularProgressIndicator();
              },
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: oldInspectionList,
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
      return  ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow:[
                BoxShadow(
                color: Colors.green
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
                      Text('Пройдений кілометраж: ${inspectionList[inspectionList.length - 1].mileage.toString()} км'),
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

    Widget listInfo(List<User> userList, List<Inspection> oldInspectionList, List<Inspection> futureInspectionList) {
      getMileageList(userList);
      String lastInspection;
      String futureInspection;

      Widget oldInspectionText() {
        if(oldInspectionList.last.mileage != 0) {
            lastInspection = oldInspectionList.last.mileage.toString();
            return Text('Останій тех огляд через: $lastInspection \n');
        } else if(oldInspectionList.last.date.isNotEmpty) {
            lastInspection = oldInspectionList.last.date;
            return Text('Останій тех огляд: $lastInspection \n');
        }
      }

      Widget futureInspectionText() {
        if(futureInspectionList.last.mileage != 0) {
           futureInspection = futureInspectionList.last.mileage.toString();
           return Text('Наступний тех огляд через: $futureInspection \n');
        } else if(futureInspectionList.last.date.isNotEmpty) {
           futureInspection = futureInspectionList.last.date;
           return Text('Наступний тех огляд: $futureInspection \n');
        }
      }

      return Container(
        child: Column(
          children: <Widget>[
            Text('Пройдений кілометраж за місяць: 133 400\n'),
            Text('Пройдений кілометраж за весь час: $mileageAllTime\n'),
            oldInspectionText(),
            futureInspectionText()
          ],
        ),
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


  void getMileageList(List<User> user) {
      mileageAllTime = 0;
      if(user.isNotEmpty) {
        for (int tmp = 0; tmp < user.length; tmp++) {
            mileageAllTime = mileageAllTime +  user[tmp].mileage;
        }
      }
  }

}

