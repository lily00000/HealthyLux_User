import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

void main() => runApp(SendEmail());

class SendEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Help'),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 200.0,
                ),
                Text(
                  'Welcome to HealthyLux',
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                Text(
                  'For any Queries, Mail us',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                RaisedButton(
                    onPressed: launchMailto,
                    child: Container(
                        child: Text(
                      'Here',
                      style: TextStyle(fontSize: 20),
                    )),
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['19060201@imail.sunway.edu.my'],
      cc: ['fany_cy@hotmail.com'],
      subject: 'Customer Help',
    );

    await launch('$mailtoLink');
  }
}
