import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasmadonationtiu/Authentication/login.dart';
import 'dart:async';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  var name;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdb0b46),
        title: Text(" Verification! "),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          color: Color(0xffdb0b46),
          child: Container(
              width: 350,
              height: 200,
              color: Colors.white70,
              child: Center(
                child: Text(
                  " Verification email has been send to ${user.email} verify please!",
                  style: TextStyle(
                    fontSize: 23,
                    color: Color(0xffdb0b46),
                  ),
                ),
              )),
        ),
      ),
    ));
  }

  Future<void> checkEmailVerified() async {
    if (user.emailVerified) {
      timer.cancel();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
