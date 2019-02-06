import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';

class DoctorsPage extends StatefulWidget {
  _DoctorsPageState createState() => new _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Doctor's appointments"
            : language == rus ? "Поход к врачам" : "Shifokor ko'riklari"),
      ),
      body: SafeArea(child: Container()),
    );
  }
}
