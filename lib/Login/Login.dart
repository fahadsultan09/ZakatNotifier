
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:notifier/Home/Home.dart';
import 'package:notifier/Login/Authentication.dart';
import 'package:notifier/Login/SignUpPage.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
    
  LoginPage({
    this.auth,
    this.onSignedIn,
  });
  
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

bool obsureTextValue = true;

  void _ChangeText(){
    setState(() {
     if(obsureTextValue){
       obsureTextValue = false;
     }
     else{
       obsureTextValue = true;
     }
    });
  }


   Future moveToSignUp() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SignupPage(auth: new Auth ())));

  }

  String _email,_password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   FirebaseAuth auth = FirebaseAuth.instance;
  Future validateAndSubmit () async {
      try{
        
        var user =  await auth.signInWithEmailAndPassword(email: _email, password: _password);

        if(user!=null){
          Toast.show("Your Account has Login Successfully", context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.green[500]);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
        }
    
      }
      catch (e){
      
        if (e.toString() ==
                  "PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)") {
                Toast.show("Login Failed ! Wrong Password", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
       
      }
    
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        body: Form(
          key: _formKey,
                  child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Image(
                image: AssetImage('assets/images/images.jpg'),
                fit: BoxFit.cover,
                color: Colors.black45,
                colorBlendMode: BlendMode.darken,
              ),
            ListView(
            
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text('Zakat',
                          style: TextStyle(
                              fontSize: 55.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                      child: Text('Donar',
                          style: TextStyle(
                              fontSize: 45.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(130.0, 175.0, 0.0, 0.0),
                      child: Text('',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      new TextFormField(
                            style: new TextStyle(color: Colors.white),
                            onChanged: (value){
                             
                              _email = value;
                            },
                            validator: (input){
                                EmailFieldValidator.validate(input);
                            },
                            
                            keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(height: 20.0),
                      new TextFormField(
                            style: new TextStyle(color: Colors.white),
                            validator: (input){
                              PasswordFieldValidator.validate(input);
                            },
                            onChanged: (value){
                             
                              _password = value;
                            
                            },
                            keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                             suffixIcon: IconButton(icon: new Icon(Icons.remove_red_eye),onPressed: _ChangeText ,color: Colors.grey,),
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        obscureText: obsureTextValue,
                      ),
                     
                      SizedBox(height: 40.0),
                      GestureDetector(
                            onTap: validateAndSubmit,
                            child:  Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: CupertinoColors.activeGreen,
                          elevation: 7.0,
                            child: Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                        
                        )),
                            ),
                      SizedBox(height: 20.0),
                                      ],
                  )
                  ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    
                    'New to Our App ?',
                    style: TextStyle(fontFamily: 'Montserrat',color: Colors.white70),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: moveToSignUp,
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          )




            ],
          ),
        ) 
        
    );
  }
}
class EmailFieldValidator{
  static String validate(String input){
    if(input.isEmpty){
      return 'Please Type an Email.';
    } else {
      return null;
    }
  }
}
class PasswordFieldValidator{
  static String validate(String input){
    if (input.length < 6) {
      return 'Password length should be greater than 6.';
    } else {
      return null;
    }
  }
}