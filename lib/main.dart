import 'package:finalproject/helpers/authservice.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/doctors.dart';
import 'package:finalproject/pages/formpage.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/hospitalspage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:finalproject/pages/medicinespage.dart';
import 'package:finalproject/pages/newspage.dart';
import 'package:finalproject/pages/profileeditpage.dart';
import 'package:finalproject/pages/profilepage.dart';
import 'package:finalproject/pages/secondpage.dart';
import 'package:finalproject/pages/settingspage.dart';
import 'package:finalproject/pages/unitspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AuthService appAuth = new AuthService();
Widget _defaultHome = MyHomePage(
  title: "Final Project",
);
void main() async {
  bool result = await appAuth.login();
  if (result) {
    _defaultHome = MyHomePage(
      title: "Final Project",
    );
  } else {
    _defaultHome = LanguagePage();
  }
  runApp(MyApp());
}

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        '/language': (BuildContext context) => LanguagePage(),
        '/home': (BuildContext context) => MyHomePage(title: "Final Project"),
        '/secondPage': (BuildContext context) => SecondPage(),
        '/form': (BuildContext context) => FormPage(),
        '/settings': (BuildContext context) => SettingsPage(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/profileedit': (BuildContext context) => ProfileEditPage(),
        '/medicineadd': (BuildContext context) => AddMedicine(),
        '/units': (BuildContext context) => UnitsPage(),
        '/hospitals': (BuildContext context) => HospitalsPage(),
        '/news': (BuildContext context) => NewsPage(),
        '/doctors': (BuildContext context) => DoctorsPage(),
        '/medicines': (BuildContext context) => MedicinesPage(),
      },
    );
  }
}
