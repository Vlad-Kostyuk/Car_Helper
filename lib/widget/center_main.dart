import 'package:flutter/material.dart';

Widget bodyMain() {
  return Container(
    child: Column(
      children: <Widget>[
        Expanded(
          //flex: 1,
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
          //flex: 2,
          child: Container(
            child: Column(
              children: <Widget>[
                Text('Пройдений кілометраж за місяць: 123 400\n'),
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
