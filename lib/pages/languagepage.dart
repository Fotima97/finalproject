import 'package:finalproject/helpers/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

String language;

class LanguagePage extends StatefulWidget {
  LanguagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  List<DropdownMenuItem<String>> _dropdDownMenuItems;
  String _dropdownvalue;
  @override
  void initState() {
    super.initState();
    checkLanguage();
    _dropdDownMenuItems = _getmenuitems();
    _dropdownvalue = _dropdDownMenuItems[0].value;
  }

  setLanguage(String input) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(languageState, input);
  }

  checkLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(languageState) != null) {
      if (preferences.getString(languageState) == eng) {
        language = eng;
      } else if (preferences.getString(languageState) == rus) {
        language = rus;
      } else {
        language = uzb;
      }
    } else {
      language = eng;
    }
  }

  List<DropdownMenuItem<String>> _getmenuitems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(DropdownMenuItem(
      value: eng,
      child: Container(
        child: Text("ENG"),
        padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.0),
      ),
    ));
    items.add(DropdownMenuItem(
      value: rus,
      child: Container(
        child: Text("RUS"),
        padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.0),
      ),
    ));
    items.add(DropdownMenuItem(
      value: uzb,
      child: Container(
        child: Text("UZB"),
        padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.0),
      ),
    ));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: Colors.deepPurpleAccent.withGreen(1)));
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(
                      canvasColor: greyColor, backgroundColor: primaryColor),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: greyColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 1.0,
                          )
                        ]),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _dropdownvalue,
                        items: _dropdDownMenuItems,
                        onChanged: (v) {
                          setState(() {
                            _dropdownvalue = v;
                            language = _dropdownvalue;
                          });
                        },
                      ),
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
                        color: greenColor),
                    child: MaterialButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      height: 60.0,
                      minWidth: 250.0,
                      //color: greenColor,
                      child: Text(
                        language == uzb
                            ? "Keyingisi"
                            : language == rus ? "Следующий" : "Next",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        setLanguage(_dropdownvalue);
                        Navigator.pushNamed(context, '/secondPage');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
