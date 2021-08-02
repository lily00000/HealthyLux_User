import 'package:authendification/Help%20Section/SendEmail/sendemail.dart';
import 'package:authendification/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../calling/firebase_service.dart';
import '../calling/app_user.dart';
import 'editprofile.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseService _firebaseService = FirebaseService();
  User user;
  String imageUrl;
  int index = 0;

  AppUser _appUser = AppUser();

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();

    initData();
  }

  void refreshData() {
    initData();
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => EditProfile());
    Navigator.push(context, route).then(onGoBack);
  }

  Future initData() async {
    try {
      User currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        _appUser = await _firebaseService.getUserInfoByEmail(currentUser.email);

        print("user name  is ${_appUser.username}");
        print("image url id ${_appUser.imageUrl}");
        print("user bmi result is ${_appUser.result}");

        setState(() {});
      }

      print("currentUser ${currentUser.email}");
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.redAccent,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home, color: Colors.white),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded, color: Colors.white),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              label: 'Sign Out',
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            } else if (index == 2) {
              signOut();
            }
          },
        ),
        appBar: AppBar(
          title: Text('User Profile'),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: Color(0xFFfdfdfd),
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    (_appUser.imageUrl != null)
                        ? Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_appUser.imageUrl),
                                )),
                          )
                        : Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('images/Login.jpg'),
                                )),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("User Name", _appUser.username),
              buildTextField("E-mail", _appUser.email),
              buildTextField("Age", "${_appUser.age}"),
              buildTextField("BMI", "${_appUser.result}"),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                      onPressed: () {
                        navigateSecondPage();
                      },
                      child: Text('Edit Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: RaisedButton(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SendEmail()),
                      );
                    },
                    child: Text('Need help...',
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
      ),
    );
  }
}
