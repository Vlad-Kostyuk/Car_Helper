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
                  Text('Пройдений кілометраж за весь час: 133 400\n'),
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
                  return list(snapshot.data);
                }
                if(snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Data Found');
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
        itemCount: inspectionList.length,
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
              leading: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  DBProvider.db.deleteInspection(inspectionList[index].id);
                  setState(() {
                    updateInspectionList();
                  });
                }
              ),
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

