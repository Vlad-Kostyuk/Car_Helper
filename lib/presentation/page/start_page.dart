import 'package:carhelper/presentation/widget/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'login/login_user.dart';

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
            'Login',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme:  IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white70,
        ),
        drawer: DrawerMenu(),
        body: LoginUser(),
      ),
    );
  }
}
