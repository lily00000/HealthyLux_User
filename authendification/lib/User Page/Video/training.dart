import 'package:authendification/User%20Page/Video/VideoAdominal.dart';
import 'package:authendification/User%20Page/Video/trainingarm.dart';
import 'package:authendification/User%20Page/Video/trainingback.dart';
import 'package:authendification/User%20Page/Video/trainingchest.dart';
import 'package:authendification/User%20Page/Video/trainingleg.dart';
import 'package:authendification/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authendification/MyProfile/profile.dart';

class Training extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int index = 0;

  signOut() async {
    _auth.signOut();
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
          title: Text('Training'),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 50.0, bottom: 0.0),
              crossAxisSpacing: 25,
              mainAxisSpacing: 60,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/RECIPE.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainingHand()),
                        );
                      },
                      child: null),
                ),
                Container(
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/RECIPE.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainingBack()),
                        );
                      },
                      child: null),
                ),
                Container(
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/RECIPE.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainingLeg()),
                        );
                      },
                      child: null),
                ),
                Container(
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/RECIPE.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainingAbdominal()),
                        );
                      },
                      child: null),
                ),
                Container(
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/RECIPE.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainingChest()),
                        );
                      },
                      child: null),
                ),
              ]),
        ),
      ),
    );
  }
}
