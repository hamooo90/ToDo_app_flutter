

import 'package:firebase_auth/firebase_auth.dart';
import 'package:yaddasht_flutter/models/theuser.dart';
import 'package:yaddasht_flutter/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // GoogleSignIn _googleSignIn = GoogleSignIn();


  //sign in anon
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInEmailPass(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future registerEmailPass(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).addUpdateUserData('', user.email);
      return _userFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  TheUser _userFromUser(User user){
    return user != null ? TheUser(uid: user.uid,email: user.email) : null;
  }

  Stream<TheUser> get user {
    return _auth.authStateChanges().map((event) => _userFromUser(event));
  }


  // Future<void> handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }


}