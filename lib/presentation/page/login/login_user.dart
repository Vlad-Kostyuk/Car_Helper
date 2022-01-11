import 'package:firebase_auth/firebase_auth.dart';
import 'package:carhelper/string/container.dart';
import 'package:carhelper/presentation/widget/center_add_inspection.dart';
import 'package:flutter/material.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key key}) : super(key: key);

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.userChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Row(
            children: [

              ElevatedButton(
                  onPressed: () async {

                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: "vlad.kostyuk24@gmail.com",
                          password: "vlad771200"
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }

                  },
              )

            ],
          ),
        ),
      )
    );
  }
}
