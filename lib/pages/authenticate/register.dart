import 'package:flutter/material.dart';
import 'package:yaddasht_flutter/services/auth.dart';
import 'package:yaddasht_flutter/shared/loading.dart';
import 'package:yaddasht_flutter/shared/style.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String password = '';

  String error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 50.0),
        child: ListView(
          children: [
            SizedBox(height: 100,),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 50,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Email'),
                    style: TextStyle(color: Colors.white),
                    validator: (val) {
                      if(val.isEmpty){
                        return 'Enter an Email!';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },

                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Password'),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (val){
                      if(val.length<6){
                        return 'Enter a password 6+ chars long';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },

                  ),
                  SizedBox(height: 30),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Colors.orangeAccent,
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        // print(email);
                        // print(password);
                        setState(() {
                          loading = true;
                          error = '';
                        });
                        dynamic result = await _auth.registerEmailPass(email, password);
                        // print(result);
                        setState(() {
                          loading = false;
                        });

                        if(result == null){
                          print('something went wrong');
                          setState(() {
                            error = 'something went wrong';
                          });

                        }
                      }
                    },
                  ),
                  // SizedBox(height: 5,),
                  SizedBox(height: 30,
                    child: loading ? Loading():Text(
                      error,
                      style: TextStyle(color: Colors.red,fontSize: 18,),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Have an account? ',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            Center(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.white,
                child: Text(
                  'Log in with Email',
                  style: TextStyle(color: Colors.orangeAccent[700]),
                ),
                onPressed: (){widget.toggleView();},
              ),
            ),
          ]
        ),
      ),
    );
  }
}
