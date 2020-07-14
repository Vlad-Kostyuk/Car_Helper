import 'package:carhelper/container.dart';
import 'package:carhelper/widget/Drawer.dart';
import 'package:carhelper/widget/center_main.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            kTitleAppBar,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white70,
        ),
        drawer: drawerMenu(),
        body: bodyMain(),
      ),
    );
  }
}
