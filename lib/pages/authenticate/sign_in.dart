import 'package:flutter/material.dart';
import 'package:yaddasht_flutter/services/auth.dart';
import 'package:yaddasht_flutter/shared/loading.dart';
import 'package:yaddasht_flutter/shared/style.dart';



class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

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
                  // SizedBox(height: 150,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Email'),
                    style: TextStyle(color: Colors.white),
                    validator: (val) {
                      if(val.isEmpty){
                        return 'Enter an Email!';
                      } else {
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
                      'Log in',
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
                        dynamic result = await _auth.signInEmailPass(email, password);
                        setState(() {
                          loading = false;
                        });
                        // print(result);

                        if(result == null){
                          print('something went wrong');
                          setState(() {
                            error = 'something went wrong ';
                            // loading = false;
                          });

                        }
                      }
                    },
                  ),
                  // SizedBox(height: 5,),

                  SizedBox(height: 30,
                    child: Center(
                      child: loading ? Loading():Text(
                        error,
                        style: TextStyle(color: Colors.red,fontSize: 20,),
                      ),
                    ),
                  ),


                ],
              ),
            ),
             SizedBox(height: 10),
            Center(
              child: Text(
                'Need an account?',
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
                  'Sign up with Email',
                  style: TextStyle(color: Colors.orangeAccent[700]),
                ),
                onPressed: (){widget.toggleView();},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
