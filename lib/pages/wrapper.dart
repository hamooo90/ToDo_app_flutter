
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yaddasht_flutter/models/theuser.dart';
import 'package:yaddasht_flutter/pages/authenticate/authenticate.dart';
import 'package:yaddasht_flutter/pages/home/home.dart';
import 'package:yaddasht_flutter/services/auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // return StreamBuilder<TheUser>(
    //   stream: AuthService().user,
    //   builder: (context,snapshot){
    //     if(snapshot.hasData){
    //       return Home();
    //     }else{
    //       return SignRegLoad();
    //     }
    //   },
    // );
    return StreamProvider<TheUser>.value(
      value: AuthService().user,
      child: UnWrapper(),
    );

  }
}


class UnWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    if(user == null){
      return Authenticate();
    } else{
      return Home();
    }
  }
}

