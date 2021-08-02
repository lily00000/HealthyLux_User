import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authendification/calling/app_user.dart';
import 'package:authendification/calling/firebase_service.dart';

String email, result;

class ResultScreen extends StatefulWidget {
  String result2;
  String msg;
  String des;
  ResultScreen(this.result2, this.msg, this.des);
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  FirebaseService _firebaseService = FirebaseService();

  AppUser _appUser = AppUser();

  showAlertDialog(BuildContext context) {
    Widget okButton =
        FlatButton(child: Text("OK"), onPressed: () => Navigator.pop(context));

    AlertDialog alert = AlertDialog(
      title: Text("BMI Result"),
      content: Text("Your BMI result have been saved."),
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

  void saveData() async {
    email = _appUser.email;
    result = widget.result2;
    User currentUser = FirebaseAuth.instance.currentUser;
    await _firebaseService.updateBmi(
        "${currentUser.email}", double.parse(result));
    print("Email===>>>> ${currentUser.email}");
    print("result===>>> ${double.parse(result)}");
    showAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text("BMI RESULT"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Text(
              "Your Result",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.result2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.des,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  onPressed: () {
                    saveData();
                  },
                  child: Text('Save Result',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              color: Colors.redAccent,
              child: Text(
                "Recalculate",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
