import 'Firebase Functions/firebase-actions.dart';
import 'Authentication/switchpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Firebase Functions/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: FirebaseActions().userStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SwitchPage(),
      ),
    );
  }
}
