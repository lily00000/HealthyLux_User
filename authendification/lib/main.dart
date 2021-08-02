import 'package:authendification/Help%20Section/Guide/userguide.dart';

import 'package:authendification/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:authendification/Start.dart';

import 'package:flutter/services.dart';

void main() async {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Start(),
    );
  }
}
