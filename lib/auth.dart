import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


abstract class BaseAuth{
  Future<String> signIn(String email,String password);
  Future<String> currentUser();
}

class Auth implements BaseAuth{
  @override
  Future<String> currentUser() async{
    // TODO: implement currentUser
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  @override
  Future<String> signIn(String email, String password) async{
    // TODO: implement signIn
    FirebaseUser user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

}