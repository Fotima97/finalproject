import 'package:finalproject/helpers/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  _setloginState(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(loginState, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: accentColor),
                    child: MaterialButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      height: 60.0,
                      minWidth: 250.0,
                      child: Text(
                        language == eng
                            ? 'Fill in form'
                            : language == rus
                                ? "Заполните форму"
                                : "Formani to'ldiring",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/form');
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Color(0xFFC1C3F3)),
                    child: MaterialButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      height: 60.0,
                      minWidth: 250.0,
                      //color: greenColor,
                      child: Text(
                        language == eng
                            ? 'Skip'
                            : language == rus
                                ? "Пропустить"
                                : "O'tkazib yuborish",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        _setloginState(true);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
