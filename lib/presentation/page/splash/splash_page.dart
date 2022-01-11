import 'package:carhelper/presentation/page/start_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashP extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Splash(), debugShowCheckedModeBanner: false);
        } else {
          // Loading is done, return the app:
          return MainPage();
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode = MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "Car Helper", style: TextStyle(color: Colors.black, fontSize: 50),
              ),

              SizedBox(
                height: 5,
              ),

              Container(
                child: lightMode ?
                Image.asset('assets/logo.png') :
                Image.asset('assets/img.png'),
              ),

            ],
          ),
      )
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 3));
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}