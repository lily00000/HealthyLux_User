import 'package:flutter/material.dart';
import 'package:authendification/BMI/calResult.dart';
import 'package:authendification/BMI/result.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender {
  male,
  female,
}

Gender selectedGender;

const kActiveColor = Colors.redAccent;
const kInctiveColor = Color(0xFF5A5555);

Color femaleCont = kInctiveColor;
Color maleCont = kActiveColor;

int height = 170;
int weight = 52;
int age = 20;

const kLabelText = TextStyle(fontSize: 18.0, color: Colors.white);

const kNumberText =
    TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold, color: Colors.white);

class BMIHomepage extends StatefulWidget {
  @override
  _BMIHomepageState createState() => _BMIHomepageState();
}

class _BMIHomepageState extends State<BMIHomepage> {
  @override
  void initState() {
    setState(() {
      selectedGender = Gender.male;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        color: Color(0xfdfdfd),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusesableContainer(
                        opt: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        customChild: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                FontAwesomeIcons.mars,
                                size: 110,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('MALE', style: kLabelText),
                            ],
                          ),
                        ),
                        contColor: selectedGender == Gender.male
                            ? kActiveColor
                            : kInctiveColor,
                      ),
                    ),
                    Expanded(
                      child: ReusesableContainer(
                        opt: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                        customChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              FontAwesomeIcons.venus,
                              size: 110,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('FEMALE', style: kLabelText),
                          ],
                        ),
                        contColor: selectedGender == Gender.female
                            ? kActiveColor
                            : kInctiveColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusesableContainer(
                          contColor: kActiveColor,
                          customChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'SELECT HEIGHT',
                                style: kLabelText,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    height.toString(),
                                    style: kNumberText,
                                  ),
                                  Text(
                                    'CM',
                                    style: kLabelText,
                                  ),
                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 16.0),
                                  thumbColor: kInctiveColor,
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 50.0),
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor: Colors.green,
                                ),
                                child: Slider(
                                  value: height.toDouble(),
                                  min: 50.0,
                                  max: 280.0,
                                  onChanged: (double changeHeight) {
                                    setState(() {
                                      height = changeHeight.round();
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusesableContainer(
                        contColor: kActiveColor,
                        customChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'WEIGHT',
                              style: kLabelText,
                            ),
                            Text(
                              weight.toString(),
                              style: kNumberText,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                btnPlussMinus(
                                  buttonIcon: FontAwesomeIcons.minus,
                                  onPress: () {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                btnPlussMinus(
                                  buttonIcon: FontAwesomeIcons.plus,
                                  onPress: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusesableContainer(
                        contColor: kActiveColor,
                        customChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'AGE',
                              style: kLabelText,
                            ),
                            Text(
                              age.toString(),
                              style: kNumberText,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                btnPlussMinus(
                                  buttonIcon: FontAwesomeIcons.minus,
                                  onPress: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                btnPlussMinus(
                                  buttonIcon: FontAwesomeIcons.plus,
                                  onPress: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  NavigationToResult(12.0);
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'CALCULATE BMI',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  height: 75.0,
                  width: double.infinity,
                  color: Colors.redAccent,
                  margin: EdgeInsets.only(top: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void NavigationToResult(double result) {
    CalculateResult obj = CalculateResult(weight, height);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(
                obj.calculateResult(), obj.msg, obj.getDescription())));
  }
}

class btnPlussMinus extends StatelessWidget {
  btnPlussMinus({this.buttonIcon, this.onPress});
  final IconData buttonIcon;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(buttonIcon),
      onPressed: onPress,
      fillColor: kInctiveColor,
      constraints: BoxConstraints.tightFor(
        width: 44.0,
        height: 44.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }
}

class ReusesableContainer extends StatelessWidget {
  ReusesableContainer({@required this.contColor, this.customChild, this.opt});
  final Color contColor;
  final Widget customChild;
  final Function opt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: opt,
      child: Container(
        child: customChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: contColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
