import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/words.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _radiovalue;
  bool _switchvalue = true;
  TextStyle style = TextStyle(color: Colors.black45, fontFamily: "Roboto");
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;

  BoxDecoration containerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(5.0, 5.0),
          color: Color(0xffEDEDED),
          blurRadius: 5.0,
        )
      ]);
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationPlugin = new FlutterLocalNotificationsPlugin();

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
      setNotificationsStatus(value);
      if (!value) {
        cancelNotifications();
      }
    });
  }

  cancelNotifications() async {
    await flutterLocalNotificationPlugin.cancelAll();
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

  setNotificationsStatus(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(notificationsStatus, value);
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
          color: Color(0xfffdfdfe),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0),
                decoration: containerDecoration,
                child: Column(
                  children: <Widget>[
                    Text(
                      language == eng
                          ? "Language"
                          : language == rus ? "Язык" : "Til",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    ListTile(
                        title: Text(
                          "O'zbekcha",
                          style: style,
                        ),
                        trailing: Radio(
                          value: 0,
                          groupValue: _radiovalue,
                          onChanged: (int value) {
                            radioValueChanged(value);
                          },
                          activeColor: primaryColor,
                        )),
                    ListTile(
                        title: Text("Русский", style: style),
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
                        title: Text("English", style: style),
                        trailing: Radio(
                          value: 2,
                          groupValue: _radiovalue,
                          onChanged: (int value) {
                            radioValueChanged(value);
                          },
                          activeColor: primaryColor,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                decoration: containerDecoration,
                child: ListTile(
                  title: Text(
                      notifications = language == eng
                          ? "Notifications"
                          : language == rus ? "Уведомления" : "Xabarnoma",
                      style: style),
                  trailing: Switch(
                    value: _switchvalue,
                    onChanged: (bool value) {
                      _onSwitchChange(value);
                    },
                    activeColor: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
