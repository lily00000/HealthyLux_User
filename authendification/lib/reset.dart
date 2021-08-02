import 'package:authendification/Login.dart';
import 'package:authendification/Start.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authendification/homepage.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      }
    });
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Reset password"),
      content: Text("Request link have been sent. Please check your Mailbox"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  reset() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        await _auth.sendPasswordResetEmail(email: _email);
        showAlertDialog(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Reset Password"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.redAccent, fontSize: 30),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                      validator: (input) {
                        if (input.isEmpty) return 'Enter Email';
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enter email",
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email)),
                      onSaved: (input) => _email = input),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 60,
                    width: 180,
                    child: RaisedButton(
                        color: Colors.redAccent,
                        onPressed: reset,
                        child: Text(
                          "Send Request",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
