import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:authendification/MyProfile/profile.dart';
import 'package:authendification/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class UserRecipeScreen extends StatefulWidget {
  @override
  _UserRecipeScreenState createState() => _UserRecipeScreenState();
}

class _UserRecipeScreenState extends State<UserRecipeScreen> {
  CollectionReference ref = FirebaseFirestore.instance.collection("recipe");

  final _screenshotController = ScreenshotController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  signOut() async {
    _auth.signOut();
  }

  int selectedIndex = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text(
            'Recipe',
          ),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                    itemBuilder: (_, index) {
                      var doc = snapshot.data.docs[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Screenshot(
                                    controller: _screenshotController,
                                    child: Container(
                                      child: Dialog(
                                        child: Container(
                                          color: Colors.grey[300],
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: ListView(children: <Widget>[
                                              Image.network(
                                                doc['imageUrl'],
                                                fit: BoxFit.fill,
                                                height: 300,
                                                width: 300,
                                              ),
                                              SizedBox(height: 15.0),
                                              Text(
                                                  snapshot.data.docs[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                      color: Color(0xFF794B00),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 17.0),
                                              Text(
                                                  snapshot.data.docs[index]
                                                      ['calories'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 16.0),
                                              Text('Ingredients:',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                snapshot.data.docs[index]
                                                    ['ingredient'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 17.0),
                                              Text('Instructions:',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                snapshot.data.docs[index]
                                                    ['instruction'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 20.0),
                                              TextButton(
                                                  onPressed: () async {
                                                    final pdfFile =
                                                        await PdfApi.generate(
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['name'],
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['calories'],
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['ingredient'],
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['instruction'],
                                                            doc['imageUrl']);

                                                    PdfApi.openFile(pdfFile);
                                                  },
                                                  child: Text(
                                                    "Print",
                                                    style: TextStyle(
                                                        color: Colors.blue[900],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 150,
                          color: Colors.black12,
                          child: Center(
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      child: Image.network(
                                        snapshot.data.docs[index]['imageUrl'],
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: 100,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data.docs[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF794B00),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data.docs[index]['calories'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
        ));
  }

  Future saveAndShare(bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}');

    await Share.shareFiles([image.path]);
  }
}

class PdfApi {
  static Future<File> generate(
      String name, calories, ingredient, instruction, imageUrl) async {
    final pdf = pw.Document();
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();
    final image = pw.MemoryImage(
      bytes,
    );
    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
    );
    pdf.addPage(
      pw.MultiPage(
          build: (
            context,
          ) =>
              <pw.Widget>[
                pw.Row(
                  children: [
                    pw.PdfLogo(),
                    pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
                    pw.Text("HealthyLux",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                          color: PdfColors.black,
                        )),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Image(
                  image,
                  width: pageTheme.pageFormat.availableWidth / 1,
                  height: 300,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  name,
                  style: pw.TextStyle(
                    decoration: pw.TextDecoration.underline,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  calories,
                  style: pw.TextStyle(
                    decoration: pw.TextDecoration.underline,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "Ingredients:",
                  style: pw.TextStyle(
                    decoration: pw.TextDecoration.underline,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  ingredient,
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "Instructions:",
                  style: pw.TextStyle(
                    decoration: pw.TextDecoration.underline,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  instruction,
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
              ],
          footer: (context) {
            final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
              child: pw.Text(
                text,
                style: pw.TextStyle(color: PdfColors.black),
              ),
            );
          }),
    );
    return saveDocument(name: name, pdf: pdf);
  }

  static Future<File> saveDocument({
    String name,
    pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
