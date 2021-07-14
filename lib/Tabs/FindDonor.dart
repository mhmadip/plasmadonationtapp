import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plasmadonationtiu/Firebase%20Functions/firebase-actions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class FindDonor extends StatefulWidget {
  @override
  _FindDonorState createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  UploadTask task;
  final firestore = FirebaseFirestore.instance; //
  FirebaseAuth auth = FirebaseAuth
      .instance; //recommend declaring a reference outside the methods
  String nameUser;
  Future<String> getUserName() async {
    final CollectionReference users = firestore.collection('Users');

    final String uid = auth.currentUser.uid;

    final result = await users.doc(uid).get();

    return result.get(['Name']);
  }

  FirebaseActions lauth = FirebaseActions();

  List collectPosts = [];
  List bloodTypeFilterList = [];

  fetchPosts() async {
    dynamic result = await PostsInformation().getPosts();

    if (result == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        collectPosts = result;
      });
    }
  }

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
    setState(() {
      fetchPosts();
      getUserName();
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloodGroupController;
    //print(bloodGroupController.toString());

    // print(abc);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdb0b46),
        title: Text("Find Donors "),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
            child: Column(children: [
              new Row(
                children: <Widget>[
                  Flexible(
                    child: DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'Please provide blood group' : null,
                      onChanged: (val) {
                        setState(() {
                          bloodGroupController = val;
                          bloodTypeFilterList.clear();

                          collectPosts.forEach((element) {
                            if (element["Blood Type"].toString() ==
                                "$bloodGroupController") {
                              bloodTypeFilterList.add(element);
                              print(bloodTypeFilterList);
                            }
                          });
                        });
                        print(bloodGroupController.toString());
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      hint: Text("Blood Group"),
                      items: [
                        DropdownMenuItem(
                          child: Text("A+"),
                          value: "A+",
                        ),
                        DropdownMenuItem(
                          child: Text("B+"),
                          value: "B+",
                        ),
                        DropdownMenuItem(
                          child: Text("O+"),
                          value: "O+",
                        ),
                        DropdownMenuItem(
                          child: Text("AB+"),
                          value: "AB+",
                        ),
                        DropdownMenuItem(
                          child: Text("A-"),
                          value: "A-",
                        ),
                        DropdownMenuItem(
                          child: Text("B-"),
                          value: "B-",
                        ),
                        DropdownMenuItem(
                          child: Text("O-"),
                          value: "O-",
                        ),
                        DropdownMenuItem(
                          child: Text("AB-"),
                          value: "AB-",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Flexible(
                    child: DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'Please provide your state' : null,
                      onChanged: (val) {
                        var genderController;
                        genderController.text = val;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      hint: Text("Select your state"),
                      items: [
                        DropdownMenuItem(child: Text("Erbil"), value: "Erbil"),
                        DropdownMenuItem(
                          child: Text("Slemani"),
                          value: "Slemani",
                        ),
                        DropdownMenuItem(
                          child: Text("Duhok"),
                          value: "Duhok",
                        ),
                        DropdownMenuItem(
                          child: Text("karkuk"),
                          value: "Karkuk",
                        ),
                        DropdownMenuItem(
                          child: Text("Zaxo"),
                          value: "Zaxo",
                        ),
                        DropdownMenuItem(
                          child: Text("Soran"),
                          value: "Soran",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              /* Container(
                width: 120.0,
                height: 40.0,
                margin: EdgeInsets.all(8),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {},
                  color: Color(0xffdb0b46),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),*/
              Container(
                height: double.maxFinite,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Container(
                          width: MediaQuery.of(context).size.height / 1,
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: bloodTypeFilterList.isNotEmpty
                              // collectPosts[index]['Blood Type']
                              ? ListView.builder(
                                  itemCount: bloodTypeFilterList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height: 260,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Container(
                                                    height: 50,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffdb0b46),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45)),
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: Text(
                                                    bloodTypeFilterList[index]
                                                        ['Name'],
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            7),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 15,
                                                      horizontal: 5),
                                                  child: Text(
                                                      bloodTypeFilterList[index]
                                                          ['Date']),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Text(
                                                            "Blood Type  :",
                                                            style:
                                                                cstmTextCard),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Text(
                                                          bloodTypeFilterList[
                                                                  index]
                                                              ['Blood Type'],
                                                          style: cstmTextCard,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Text(
                                                            "City               :",
                                                            style:
                                                                cstmTextCard),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Text(
                                                            bloodTypeFilterList[
                                                                index]['City'],
                                                            style:
                                                                cstmTextCard),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Text(
                                                            "Phone          :",
                                                            style:
                                                                cstmTextCard),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {});
                                                            FlutterPhoneDirectCaller
                                                                .callNumber(
                                                                    bloodTypeFilterList[
                                                                            index]
                                                                        [
                                                                        'Phone']);
                                                          },
                                                          child: Text(
                                                              bloodTypeFilterList[
                                                                      index]
                                                                  ['Phone'],
                                                              style:
                                                                  cstmTextCardPhone),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Text(
                                                            "User ID        :",
                                                            style:
                                                                cstmTextCard),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: InkWell(
                                                              onTap: () {
                                                                setState(() {});
                                                                Clipboard.setData(
                                                                        ClipboardData(
                                                                            text:
                                                                                bloodTypeFilterList[index]['User ID']))
                                                                    .then((_) {
                                                                  Scaffold.of(
                                                                          context)
                                                                      // ignore: deprecated_member_use
                                                                      .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text("Copied !")));
                                                                });
                                                              },
                                                              child: Icon(Icons
                                                                  .content_copy_outlined)))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    "No Data Recorded",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                )),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

final cstmText = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
final cstmTextCard = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
final cstmTextCardPhone = TextStyle(
  fontSize: 18,
  decoration: TextDecoration.underline,
  fontWeight: FontWeight.w400,
);
