import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import '../Tabs/homeTab.dart';
import '../Firebase Functions/user.dart';

class SwitchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<AppUser>(context);
    if (userState == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}
