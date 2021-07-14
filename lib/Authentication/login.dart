import 'register.dart';
import 'package:flutter/material.dart';
import '../Tabs/homeTab.dart';
import '../Firebase Functions/firebase-actions.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkeylog = GlobalKey<FormState>();
  bool _isHiddenLogPass = true;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  //FirebaseAuth _auth = FirebaseAuth.instance;

  void _toggleVisibilitylogpass() {
    setState(() {
      _isHiddenLogPass = !_isHiddenLogPass;
    });
  }

  void validatelog() {
    if (formkeylog.currentState.validate()) {
      print("Validated");
    } else {
      print("Not Validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formkeylog,
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              //color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: SvgPicture.asset(
                        'assets/doctor.svg',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      width: 300,
                      height: 50,
                      child: TextFormField(
                        controller: loginEmailController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xffdb0b46),
                            size: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: 'Email',
                        ),
                        validator: (String email) {
                          if (email.isEmpty) {
                            return "Required";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(email)) {
                            return "Email not correct";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      controller: loginPasswordController,
                      obscureText: _isHiddenLogPass,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Color(0xffdb0b46),
                            size: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: _isHiddenLogPass
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              _toggleVisibilitylogpass();
                            },
                          )),
                      validator: (String logpass) {
                        if (logpass.length < 8) {
                          return "Password is not correct";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 70),
                  TextButton(
                    onPressed: () async {
                      validatelog();
                      dynamic user = await FirebaseActions().userLogin(
                          loginEmailController.text,
                          loginPasswordController.text);
                      if (user != null) {
                        print(user.userID);
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        });
                      } else {
                        print("Login Error ..!");
                      }
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      color: Color(0xffdb0b46),
                      padding: EdgeInsets.all(14),
                      child: const Text('LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Padding(
                        padding:EdgeInsets.only(bottom: 10),
                        child:   Text("Don't have an account ?"),),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                            print('Register');
                          },
                          child: Padding(
                            padding:EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Sign up Now',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffdb0b46),
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
