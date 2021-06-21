
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yaddasht_flutter/models/theuser.dart';
import 'package:yaddasht_flutter/pages/home/home.dart';
import 'package:yaddasht_flutter/pages/home/test.dart';
import 'file:///C:/Users/Hamed/AndroidStudioProjects/yaddasht_flutter/lib/pages/authenticate/authenticate.dart';
import 'package:yaddasht_flutter/pages/wrapper.dart';
import 'package:yaddasht_flutter/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/' ,
    routes: {
      '/' : (context) => Wrapper(),
      '/home' : (context) => Home(),
      // '/test' : (context) => Test(),
    },
  ));
}




