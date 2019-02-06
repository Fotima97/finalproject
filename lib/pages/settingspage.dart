import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/words.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _radiovalue;
  bool _switchvalue = true;
  @override
  void initState() {
    super.initState();
    _getSwitchValue();
    if (language == uzb) {
      _radiovalue = 0;
    } else if (language == rus) {
      _radiovalue = 1;
    } else {
      _radiovalue = 2;
    }
  }

  void radioValueChanged(int value) {
    setState(() {
      _radiovalue = value;
      if (_radiovalue == 0) {
        _savelanguage(uzb);
      } else if (_radiovalue == 1) {
        _savelanguage(rus);
      } else {
        _savelanguage(eng);
      }
    });
  }

  void _onSwitchChange(bool value) {
    setState(() {
      _switchvalue = value;
      _saveSwitchvalue(value);
    });
  }

  _saveSwitchvalue(bool input) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(switchValue, input);
  }

  _savelanguage(String language) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(languageState, language);
  }

  _getSwitchValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(switchValue) != null) {
      _switchvalue = preferences.getBool(switchValue);
    } else {
      _switchvalue = true;
    }
  }

  checkLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    checkLanguage();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          language == eng
              ? "Settings"
              : language == rus ? "Настройки" : "Sozlash",
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.all(30.0),
            children: <Widget>[
              Text(
                language == eng ? "Language" : language == rus ? "Язык" : "Til",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              ListTile(
                  title: Text("O'zbekcha"),
                  trailing: Radio(
                    value: 0,
                    groupValue: _radiovalue,
                    onChanged: (int value) {
                      radioValueChanged(value);
                    },
                    activeColor: primaryColor,
                  )),
              ListTile(
                  title: Text("Русский"),
                  trailing: Radio(
                    value: 1,
                    groupValue: _radiovalue,
                    onChanged: (int value) {
                      setState(() {
                        radioValueChanged(value);
                      });
                    },
                    activeColor: primaryColor,
                  )),
              ListTile(
                  title: Text("English"),
                  trailing: Radio(
                    value: 2,
                    groupValue: _radiovalue,
                    onChanged: (int value) {
                      radioValueChanged(value);
                    },
                    activeColor: primaryColor,
                  )),
              Divider(),
              ListTile(
                title: Text(notifications = language == eng
                    ? "Notifications"
                    : language == rus ? "Уведомления" : "Xabarnoma"),
                trailing: Switch(
                  value: _switchvalue,
                  onChanged: (bool value) {
                    _onSwitchChange(value);
                  },
                  activeColor: primaryColor,
                ),
              ),
              Divider(),
              ListTile(
                title: Text(language == eng
                    ? "About app"
                    : language == rus ? "О приложении" : "Dastur haqida"),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
