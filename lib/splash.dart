import 'package:flutter/material.dart';
import 'dart:async';

import 'login.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashState();
  }

}

class SplashState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),
        (){
      Navigator.push(context,new MaterialPageRoute(builder: (context)=> new LoginPage()));
        });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 58, 102,100),
      body: Center(child: Image.asset("assets/Group 1.png",height: 130,width: 130,))
    );
  }
}

