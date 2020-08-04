import 'package:carhelper/container.dart';
import 'package:carhelper/page/add_inspection_page.dart';
import 'package:carhelper/page/list_inspection.dart';
import 'package:carhelper/page/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
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
            leading: Icon(Icons.add),
            title: Text('Add'),
            onTap: () {
              Route route = MaterialPageRoute(builder: (context) => AddInspection());
              Navigator.push(context, route);
            },
          ),

          ListTile(
            leading: Icon(Icons.add),
            title: Text('List Inspection'),
            onTap: () {
              Route route = MaterialPageRoute(builder: (context) => ListInspection());
              Navigator.push(context, route);
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Route route = MaterialPageRoute(builder: (context) => Settings());
              Navigator.push(context, route);
            },
          ),

        ],
      ),
    );
  }
}
