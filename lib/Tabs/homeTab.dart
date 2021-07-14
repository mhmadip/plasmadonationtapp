import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plasmadonationtiu/Authentication/switchpage.dart';
import 'package:plasmadonationtiu/Firebase%20Functions/firebase-actions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:plasmadonationtiu/Tabs/donate.dart';
import 'package:plasmadonationtiu/Tabs/support.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FindDonor.dart';
import 'aboutPage.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UploadTask task;
  File file;
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffdb0b46),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  userInfo.displayName,
                  style: TextStyle(fontSize: 16),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffdb0b46),
                ),
                accountEmail: Text(
                  userInfo.email,
                  style: TextStyle(fontSize: 16),
                ),
                currentAccountPicture: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(45)),
                    height: 120.0,
                    width: 120.0,
                    child: Icon(
                      Icons.person_outline_outlined,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: InkWell(
                  onTap: () {
                    print("Home");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: ListTile(
                    title: Text(
                      "Home",
                      style: cstmText,
                    ),
                    leading: Icon(
                      Icons.home,
                      color: Color(0xffdb0b46),
                      size: 28,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DonateTab()));
                    });
                  },
                  child: ListTile(
                    title: Text(
                      "Donate",
                      style: cstmText,
                    ),
                    leading: Icon(
                      Icons.favorite,
                      color: Color(0xffdb0b46),
                      size: 28,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FindDonor()));
                    });
                  },
                  child: ListTile(
                    title: Text(
                      "Find Donor",
                      style: cstmText,
                    ),
                    leading: Icon(Icons.search_off_outlined,
                        color: Color(0xffdb0b46), size: 28),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: ListTile(
                    title: Text(
                      " Edit Profile",
                      style: cstmText,
                    ),
                    leading: Icon(
                      Icons.person,
                      color: Color(0xffdb0b46),
                      size: 28,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SupportTeam()));
                  },
                  child: ListTile(
                    title: Text(
                      "Support",
                      style: cstmText,
                    ),
                    leading: Icon(
                      Icons.support_agent,
                      color: Color(0xffdb0b46),
                      size: 28,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                  child: ListTile(
                    title: Text(
                      "About Us",
                      style: cstmText,
                    ),
                    leading: Icon(
                      Icons.info,
                      color: Color(0xffdb0b46),
                      size: 28,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 120),
              Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () async {
                    await lauth.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SwitchPage()));
                  },
                  child: ListTile(
                    title: Text(
                      "Log Out",
                      style: cstmText,
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: Color(0xffdb0b46),
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("All Donators"),
          centerTitle: true,
          backgroundColor: Color(0xffdb0b46),
        ),
        body: Container(
          height: double.maxFinite,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                child: Container(
                  width: MediaQuery.of(context).size.height / 1,
                  height: MediaQuery.of(context).size.height / 1.25,
                  child: collectPosts.isEmpty
                      ? Center(
                          child: Text(
                            "No Data Recorded",
                            style: TextStyle(fontSize: 17),
                          ),
                        )
                      : ListView.builder(
                          itemCount: collectPosts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                width: MediaQuery.of(context).size.width / 2,
                                height: 260,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xffdb0b46),
                                                borderRadius:
                                                    BorderRadius.circular(45)),
                                            child: Icon(
                                              Icons.person,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            collectPosts[index]['Name'],
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          child:
                                              Text(collectPosts[index]['Date']),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text("Blood Type  :",
                                                    style: cstmTextCard),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  collectPosts[index]
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
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    "City               :",
                                                    style: cstmTextCard),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    collectPosts[index]['City'],
                                                    style: cstmTextCard),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Phone          :",
                                                    style: cstmTextCard),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {});
                                                    FlutterPhoneDirectCaller
                                                        .callNumber(
                                                            collectPosts[index]
                                                                ['Phone']);
                                                  },
                                                  child: Text(
                                                      collectPosts[index]
                                                          ['Phone'],
                                                      style: cstmTextCardPhone),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("User ID        :",
                                                    style: cstmTextCard),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {});
                                                        Clipboard.setData(ClipboardData(
                                                                text: collectPosts[
                                                                        index][
                                                                    'User ID']))
                                                            .then((_) {
                                                          Scaffold.of(context)
                                                              // ignore: deprecated_member_use
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Copied !")));
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
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path;
    setState(() {
      file = File(path);
    });
  }

  final cstmText = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  final cstmTextCard = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  final cstmTextCardPhone = TextStyle(
    fontSize: 18,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.w400,
  );
}
