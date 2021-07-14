import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plasmadonationtiu/Firebase%20Functions/firebase-actions.dart';
import 'package:plasmadonationtiu/Tabs/homeTab.dart';
import '../Firebase Functions/firebase-actions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DonateTab extends StatefulWidget {
  @override
  _DonateTabState createState() => _DonateTabState();
}

class _DonateTabState extends State<DonateTab> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<FormState> formkeydonation = GlobalKey<FormState>();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController name = TextEditingController();
  User user = FirebaseAuth.instance.currentUser;
  User userInfo;

  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      userInfo = userData;
      print(userData.uid);
    });
  }

  clearTextInput() {
    setState(() {
      getBlood = null;
      city.clear();
      name.clear();
      phone.clear();
      address.clear();
    });
  }


  List donatorInfo = [];

  fetchPosts() async {
    dynamic result = await PostsInformation().getPosts();

    if (result == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        donatorInfo = result;
      });
    }
  }



  String getBlood;
  final List<String> bloodTypes = [
    'A+',
    'A-',
    'O+',
    'O-',
    'B+',
    'B-',
    'AB+',
    'AB-',
  ] ;

  @override
  void initState() {
    super.initState();
    getUserData();

    fetchPosts();
  }


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm  yyyy-MM-dd').format(now);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffdb0b46),
          title: Text("Donation"),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                });
              }),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffdb0b46),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(120),
                      bottomLeft: Radius.circular(120),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(
                              "Give and Save Someone Life",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Donate",
                                  style: TextStyle(
                                      fontSize: 27, color: Color(0xFFEBBDCA))),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Text(
                                  "Plasma",
                                  style: TextStyle(
                                      fontSize: 27, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.width / 0.9,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Form(
                        key: formkeydonation,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  child: Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: Color(0xffdb0b46),
                                            style: BorderStyle.solid,
                                            width: 0.80),
                                      ),
                                      child: Center(
                                        child: DropdownButton(
                                          hint: Text("Select Blood"),
                                          value: getBlood,
                                          onChanged: (String cvalue) {
                                            setState(() {
                                              getBlood = cvalue;
                                            });
                                          },
                                          items: bloodTypes.map((cvalue) {
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
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  child: TextFormField(
                                    controller: name,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                      labelStyle: TextStyle(
                                          color: Colors.black54, fontSize: 18),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Color(0xffdb0b46),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Color(0xffdb0b46),
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Color(0xffdb0b46),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 300,
                                height: 50,
                                child: TextFormField(
                                  controller: city,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    labelText: "City",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffdb0b46),
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
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  child: TextFormField(
                                    controller: address,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      labelText: "Address",
                                      labelStyle: TextStyle(
                                          color: Colors.black54, fontSize: 18),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Color(0xffdb0b46),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Color(0xffdb0b46),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 300,
                                height: 50,
                                child: TextFormField(
                                  controller: phone,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    labelText: "Phone",
                                    labelStyle: TextStyle(
                                        color: Colors.black54, fontSize: 18),
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
                                  validator: (var phone) {
                                    if (phone.length != 11) {
                                      return "Phone number must be 11 digit";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
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
                                          if (phone.text == null ||
                                              city.text == null ||
                                              getBlood == null ||
                                              address.text == null) {
                                            setState(() {
                                              showModalError(context);
                                            });
                                          } else {
                                            final FormState form =
                                                formkeydonation.currentState;
                                            if (form.validate()) {
                                              Map<String, dynamic> data = {
                                                "Blood Type": getBlood,
                                                "Name": name.text,
                                                "City": city.text,
                                                "Phone": phone.text,
                                                "User ID": userInfo.uid,
                                                "Date": formattedDate,
                                              };

                                              FirebaseFirestore.instance
                                                  .collection("Posts")
                                                  .add(data);

                                              print('Form is valid');
                                            } else {
                                              print('Form is invalid');
                                            }
                                            showModalPerfect(context);

                                            clearTextInput();
                                          }
                                        });
                                      });
                                    },
                                    child: Text(
                                      "I'm ready to Donate ",
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
                ),
              ],
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
              title:
                  Icon(Icons.check_circle_outline, color: Colors.red, size: 60),
              content: Container(
                width: 200,
                height: 100,
                child: Center(
                  child: Text("posted Successfully ..!"),
                ),
              ));
        });
      });
}


TextStyle tRowData = TextStyle(fontSize: 12, fontWeight: FontWeight.w200);
