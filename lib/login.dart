import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final logo = Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset("assets/Group 1.png"),
        ));

    final email = TextFormField(
      validator: (input) => input.isEmpty ? 'Email Can\'t be Empty' : null, /*{
        if (input.isEmpty) {
          *//*Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text("Please Enter Required Fields"),
                          duration: new Duration(seconds: 3),)
                    );*//*
          //return "Please Enter Email ID";
        }
      },*/
      onSaved: (input) => _email = input,
      cursorColor: Colors.white,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      style: TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(prefixIcon: Icon(Icons.email,color: Colors.white,),hintStyle: TextStyle(
        color: Colors.white
      ),
        fillColor: Colors.white,
          hintText: "Email ID",
          //labelText: "Email ID",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
    );

    final password = TextFormField(
        validator: (input) {
          if (input.length < 6) {
            /*Scaffold.of(context).showSnackBar(
                new SnackBar(
                  content: new Text("Please Enter Password"),
                  duration: new Duration(seconds: 3),)
            );*/
            return "Please provide a password";
          }
        },
        onSaved: (input) => _password = input,
      obscureText: true,
        autofocus: false,
        style: TextStyle(
            color: Colors.white
        ),
        decoration: InputDecoration(hintText: "Password",prefixIcon: Icon(Icons.lock,color: Colors.white,),
          hintStyle: TextStyle(color: Colors.white),
            //labelText: "Password",
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)));

    final loginbtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 120),
      child: MaterialButton(
        minWidth: 20.0,
        textColor: Colors.black,
        onPressed: () {
          signIn();
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text("Sign In"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
    const colors = Color(0xff0B3A66);
    const MaterialColor white = const MaterialColor(
      0xFFFFFFFF,
      const <int, Color>{
        50: const Color(0xff0B3A66),
        100: const Color(0xff0B3A66),
        200: const Color(0xff0B3A66),
        300: const Color(0xff0B3A66),
        400: const Color(0xff0B3A66),
        500: const Color(0xff0B3A66),
        600: const Color(0xff0B3A66),
        700: const Color(0xff0B3A66),
        800: const Color(0xff0B3A66),
        900: const Color(0xff0B3A66),
      },
    );

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: white
      ),
      home: Scaffold(
        backgroundColor: colors,
        body: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  logo,
                  SizedBox(height: 40.0),
                  email,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 24.0),
                  loginbtn
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState= _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()));
        print(user);
      }
      catch(e){
        print(e.message);
      }
    }
  }
}
