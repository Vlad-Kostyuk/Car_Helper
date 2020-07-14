import 'package:flutter/material.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({Key key}) : super(key: key);

  @override
  _BodyMainState createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          Expanded(
            child: Center(
              child: Expanded(
                child: Container(
                  child: Icon(
                    Icons.directions_car,
                    size: 150,
                  ),
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

        ],
      ),
    );
  }
}

