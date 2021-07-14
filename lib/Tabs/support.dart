import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupportTeam extends StatefulWidget {
  @override
  _SupportTeamState createState() => _SupportTeamState();
}

class _SupportTeamState extends State<SupportTeam> {
  String support;
  final List<String> supportCases = [
    'User Not Answer',
    'User Fake Email',
    'User Fake Address',
    'User Fake Number',
  ];

  clearTextInput() {
    setState(() {
      support = null;
      issue.clear();
      moreDetails.clear();
    });
  }

  GlobalKey<FormState> formkeysupport = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState form = formkeysupport.currentState;
    if (form.validate()) {
      Map<String, dynamic> data = {
        "Case": support,
        "Sender Email": userInfo.email,
        "Sender ID": userInfo.uid,
        "Details": moreDetails.text,
        "Issue ID": issue.text,
      };
      FirebaseFirestore.instance.collection("Support").add(data);

      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  TextEditingController issue = TextEditingController();
  TextEditingController moreDetails = TextEditingController();
  User userInfo;
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      userInfo = userData;
      print(userData.uid);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffdb0b46),
          title: Text("Support"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: formkeysupport,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Contact Support for any issue",
                      style: TextStyle(color: Color(0xffdb0b46), fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Color(0xffdb0b46),
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: Center(
                            child: DropdownButton(
                              hint: Text("Select Case"),
                              value: support,
                              onChanged: (String cvalue) {
                                setState(() {
                                  support = cvalue;
                                });
                              },
                              items: supportCases.map((cvalue) {
                                return DropdownMenuItem<String>(
                                  value: cvalue,
                                  child: Text(
                                    cvalue,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 300,
                      height: 50,
                      child: TextFormField(
                        controller: issue,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "User ID",
                          labelStyle:
                              TextStyle(color: Colors.black54, fontSize: 18),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xffdb0b46),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xffdb0b46),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xffdb0b46),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      child: Container(
                        height: 200,
                        width: 300,
                        child: TextFormField(
                          controller: moreDetails,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          expands: true,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Color(0xffdb0b46),
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Color(0xffdb0b46),
                                width: 1.0,
                              ),
                            ),
                            labelText: "Description",
                            fillColor: Colors.red,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      height: 40,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffdb0b46),
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            setState(() {
                              if (support == null ||
                                  issue.text == null ||
                                  moreDetails.text == null) {
                                setState(() {
                                  showModalError(context);
                                });
                              } else {
                                validateAndSave();
                                setState(() {
                                  showModalPerfect(context);
                                });
                                clearTextInput();
                              }
                            });
                          });
                        },
                        child: Text(
                          "Send Case",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

showModalError(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
              title: Icon(Icons.error_outlined, color: Colors.red, size: 60),
              content: Container(
                width: 200,
                height: 100,
                child: Center(
                  child: Text("Fill the Fields"),
                ),
              ));
        });
      });
}

showModalPerfect(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
              title: Icon(Icons.check_circle_outline,
                  color: Colors.red, size: 60),
              content: Container(
                width: 200,
                height: 100,
                child: Center(
                  child: Text("case has been sent Successfully ..!"),
                ),
              ));
        });
      });
}
