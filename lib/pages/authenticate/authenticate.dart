import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yaddasht_flutter/models/theuser.dart';
import 'package:yaddasht_flutter/pages/authenticate/register.dart';
import 'package:yaddasht_flutter/pages/authenticate/sign_in.dart';
import 'package:yaddasht_flutter/services/auth.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  // String txt = 'signed out';
  // String out = '';
  // final AuthService _auth = AuthService();
  // // TheUser user;
  bool showSignIN = true;
  void toggleView(){
    setState(() {
      showSignIN = !showSignIN;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(showSignIN){
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }

    // return Scaffold(
    //       body: Center(
    //         child: RaisedButton(
    //           child: Text('Sign anon'),
    //           onPressed: () async {
    //             //goHome();
    //             dynamic result = await _auth.signInAnon();
    //             print(result.toString());
    //             setState(() {
    //               out = result.toString();
    //             });
    //           },
    //         ),
    //       ),
    //     );

  }
}


