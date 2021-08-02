import 'package:authendification/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserGuide extends StatefulWidget {
  @override
  _UserGuideState createState() => _UserGuideState();
}

class _UserGuideState extends State<UserGuide> {
  PageController _pageController = new PageController();

  navigateToHomepage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Colors.redAccent,
        //   title: Text(
        //     'Welcome',
        //     style: TextStyle(
        //         color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        //   ),
        // ),
        body: Stack(
      children: [
        PageView(controller: _pageController, children: [
          Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                    // color: Colors.black,
                    // offset: Offset(4.0, 4.0),
                    )
              ],
              image: DecorationImage(
                image: AssetImage('images/phonePoster1.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                    // color: Colors.black,
                    // offset: Offset(4.0, 4.0),
                    )
              ],
              image: DecorationImage(
                image: AssetImage('images/phonePoster2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                    // color: Colors.black,
                    // offset: Offset(4.0, 4.0),
                    )
              ],
              image: DecorationImage(
                image: AssetImage('images/phonePoster3.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                    // color: Colors.black,
                    // offset: Offset(4.0, 4.0),
                    )
              ],
              image: DecorationImage(
                image: AssetImage('images/phonePoster4.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: WormEffect(),
                  onDotClicked: (index) => _pageController.animateToPage(index,
                      duration: Duration(microseconds: 250),
                      curve: Curves.bounceOut),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              child: Text(
                'SKIP',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              onTap: navigateToHomepage,
            )
          ],
        ),
      ],
    ));
  }
}
