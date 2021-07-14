import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

class FirebaseActions {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<AppUser> get userStream {
    return _auth.authStateChanges().map((User user) => _realUser(user));
  }

  AppUser _realUser(User user) {
    return user != null ? AppUser(userID: user.uid) : null;
  }


// Register Method
  Future createNewUser(String email, String password, String name) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User users = res.user;
      users.updateProfile(displayName: name);
      FirebaseFirestore.instance.collection('Users').doc().set({
        'Name': name,
        'email': email,
        'password': password,
      });

      User user = res.user;
      return AppUser(userID: user.uid);
    } catch (errer) {
      print(errer.toString());
      return null;
    }
  }

// SignOut Method
  Future<void> signOut() async {
    return await _auth.signOut();
  }

// SignIn Method
  Future userLogin(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = res.user;
      return AppUser(userID: user.uid);
    } catch (errer) {
      print(errer.toString());
      return null;
    }
  }
}

class PostsInformation {
  final CollectionReference postList =
      FirebaseFirestore.instance.collection('Posts');

  Future getPosts() async {
    List getPostData = [];

    try {
      await postList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          getPostData.add(element.data());
        });
      });
      return getPostData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
