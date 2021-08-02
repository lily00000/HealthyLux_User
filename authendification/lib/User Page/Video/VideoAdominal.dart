import 'package:authendification/calling/chewie.dart';
import 'package:authendification/calling/firebase_file.dart';
import 'package:authendification/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authendification/calling/api.dart';
import 'package:authendification/MyProfile/profile.dart';
import 'package:video_player/video_player.dart';

class TrainingAbdominal extends StatefulWidget {
  @override
  _TrainingAbdominalState createState() => _TrainingAbdominalState();
}

class _TrainingAbdominalState extends State<TrainingAbdominal> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int index = 0;
  Future<List<FirebaseFile>> futureFiles;
  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('videoAbdominal/');
  }

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
          title: Text('Abdominal Training '),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.storage_rounded, color: Colors.white),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => MyVideo()),
          //       );
          //     },
          //   ),
          // ],
        ),
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  final files = snapshot.data;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return Column(
                              children: [
                                Text(
                                  file.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                ),
                                Container(
                                  height: 300,
                                  child: ChewieListItem(
                                    videoPlayerController:
                                        VideoPlayerController.network(
                                      file.url,
                                    ),
                                    looping: true,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
}
