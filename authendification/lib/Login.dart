import 'package:authendification/homepage.dart';
import 'package:authendification/reset.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email, _password;
  checkAuthendification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthendification();
  }

  login() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  navigateToHomepage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Log In'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  child: Image(
                    image: AssetImage("images/logo1.PNG"),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Email';
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email),
                              ),
                              onSaved: (input) => _email = input),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.length < 6)
                                  return 'Please provide MINIMUM 6 character';
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: "Password",
                                focusColor: Colors.black,
                                prefixIcon: Icon(Icons.email),
                              ),
                              obscureText: true,
                              onSaved: (input) => _password = input),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: login,
                          child: Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  child: Text(
                    'Create an Account?',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: navigateToSignUp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text('Forgot Password?'),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
