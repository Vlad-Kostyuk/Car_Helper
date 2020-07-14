import 'package:carhelper/container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget drawerMenu() {
  return Drawer(
    child: ListView(
      children: <Widget>[

        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white70,
          ),

          child: Text(
            kAcountName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),

        ListTile(
          leading: Icon(Icons.message),
          title: Text('Messages'),
        ),

      ],
    ),
  );
}
