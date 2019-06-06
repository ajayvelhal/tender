import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tender/login.dart';
import 'package:tender/tenderInfo.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  signOut(context);
                },
                child: Text("Logout"))
          ],
        ),
        body: Tender(),
      ),
    );
  }

  Future<void> signOut(context) async {
    FirebaseAuth.instance.signOut();
    try {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print(e.message);
    }
  }
}
