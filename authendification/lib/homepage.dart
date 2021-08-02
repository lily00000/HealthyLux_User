import 'package:authendification/Login.dart';
import 'package:authendification/MyProfile/profile.dart';
import 'package:authendification/User%20Page/Video/VideoAdominal.dart';
import 'package:authendification/User%20Page/Video/trainingarm.dart';
import 'package:authendification/User%20Page/Video/trainingback.dart';
import 'package:authendification/User%20Page/Video/trainingchest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'User Page/List_View.dart';
import 'package:authendification/BMI/BMI_Homepage.dart';
import 'Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authendification/Start.dart';

import 'User Page/Video/training.dart';
import 'User Page/Video/trainingleg.dart';

class Homepage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int selectedIndex = 0;
  int index = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  signOut() async {
    _auth.signOut();
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
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
          title: Text('Training and Diet'),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: Container(
          width: 450,
          height: 760,
          color: Color(0xFF0fdfdfd),
          child: Stack(
            children: <Widget>[
              Container(
                height: 250.0,
                width: 450.0,
                margin: EdgeInsets.only(top: 20.0),

                decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(4.0, 4.0),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage('images/RECIPE.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                // ignore: deprecated_member_use
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserRecipeScreen()),
                      );
                    },
                    child: null),
              ),
              Positioned(
                top: 250,
                child: Container(
                  width: 450,
                  height: 150,
                  margin: EdgeInsets.only(
                    top: 30.0,
                  ),

                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(4.0, 4.0),
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage('images/BMI.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BMIHomepage()),
                        );
                      },
                      child: null),
                ),
              ),
              Positioned(
                top: height * 2.7,
                left: 0,
                right: 0,
                child: Container(
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 20),
                        child: Text(
                          "Training Tutorial __________________________",
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            for (int x = 0; x < video.length; x++)
                              _VideoCard(
                                video: video[x],
                              ),
                          ],
                        ),
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.white,
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Videos {
  final String videoCatogory, imagePath;
  int index;

  Videos({
    this.videoCatogory,
    this.imagePath,
    this.index,
  });
}

final video = [
  Videos(
    videoCatogory: "Abdominal",
    imagePath: "images/Abdominal.PNG",
    index: 0,
  ),
  Videos(
    videoCatogory: "Arm",
    imagePath: "images/arm.jpg",
    index: 1,
  ),
  Videos(
    videoCatogory: "Leg",
    imagePath: "images/leg.PNG",
    index: 2,
  ),
  Videos(
    videoCatogory: "Back",
    imagePath: "images/back.png",
    index: 3,
  ),
  Videos(
    videoCatogory: "Pectoral",
    imagePath: "images/chest.PNG",
    index: 4,
  ),
];

class _VideoCard extends StatelessWidget {
  final Videos video;
  const _VideoCard({Key key, @required this.video}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 20, bottom: 5),
        child: GestureDetector(
          onTap: () {
            if (video.index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrainingAbdominal()),
              );
            } else if (video.index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrainingHand()),
              );
            } else if (video.index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrainingLeg()),
              );
            } else if (video.index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrainingBack()),
              );
            } else if (video.index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrainingChest()),
              );
            }
          },
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                    fit: FlexFit.tight,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(
                        video.imagePath,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                    )),
                Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.videoCatogory,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
