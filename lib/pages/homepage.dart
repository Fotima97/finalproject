import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

String fullname = "";
String birthdate = "";
String bloodtype = "";
String allergise = "";
List<String> savedImages = [];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double boxHeight = 180.0;
  @override
  void initState() {
    checkLanguage();
    _getProfilevalues();
    getsavedImages();
    super.initState();
  }

  getsavedImages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getStringList(photos) != null) {
      savedImages = preferences.getStringList(photos);
    } else {
      savedImages = [];
    }
  }

  _getProfilevalues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(userFullName) != null) {
      fullname = preferences.getString(userFullName);
    } else {
      fullname = "...";
    }
    if (preferences.getString(userBirthDate) != null) {
      birthdate = preferences.getString(userBirthDate);
    } else {
      birthdate = "...";
    }
    if (preferences.getString(userBloodType) != null) {
      bloodtype = preferences.getString(userBloodType);
    } else {
      bloodtype = "...";
    }
    if (preferences.getString(userAllergies) != null) {
      allergise = preferences.getString(userAllergies);
    } else {
      allergise = "...";
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: (Tooltip(
          message: language == eng
              ? "Profile"
              : language == rus ? "Профиль" : "Profil",
          child: MaterialButton(
            color: Color(0xFFAE80FC),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
            minWidth: 20.0,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        )),
        title: Text(widget.title),
        actions: <Widget>[
          Tooltip(
            message: language == eng
                ? "Settings"
                : language == rus ? "Настройки" : "Sozlash",
            child: MaterialButton(
              minWidth: 20.0,
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          children: <Widget>[
            Calendar(
              showCalendarPickerIcon: false,
            ),
            SizedBox(
              height: 40.0,
            ),
            InkWell(
              child: Container(
                height: boxHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/pills.jpg'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken)),
                  //  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.0, vertical: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        language == eng
                            ? "Pill Reminder"
                            : language == rus
                                ? "Напоминалка Таблеток"
                                : "Dori Eslatma ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        "1 pill to take",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/medicineadd');
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 12,
                  child: InkWell(
                    child: Container(
                      height: boxHeight,
                      //    width: 155.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/doctor.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black45, BlendMode.darken)),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              language == eng
                                  ? "Doctor's appointments tracker"
                                  : language == rus
                                      ? "Отслеживание посещения врача"
                                      : "Vrach tashrifi nazorati",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              "no notes for today",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.0),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 12,
                  child: InkWell(
                    child: Container(
                      height: boxHeight,
                      //   width: 155.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/news.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black45, BlendMode.darken)),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              language == eng
                                  ? "News"
                                  : language == rus ? "Новости" : "Yangiliklar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              child: Container(
                height: boxHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/hospital.jpg'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken)),
                  //  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.0, vertical: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        language == eng
                            ? "Hospitals"
                            : language == rus ? "Больницы" : "Shifoxonalar ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}