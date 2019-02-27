import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';

class UnitsPage extends StatefulWidget {
  _UnitsPageState createState() => new _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Units"
            : language == rus ? "Единицы" : "Birliklari"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            ListTile(
              title: Text(language == eng
                  ? "Tablet(s)"
                  : language == rus ? "Таблетка(и)" : "tabletka"),
              onTap: () {
                dose = language == eng
                    ? "Tablet(s)"
                    : language == rus ? "Таблетка(и)" : "tabletka";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
            ListTile(
              title:
                  Text(language == eng ? "ml" : language == rus ? "мл" : "ml"),
              onTap: () {
                dose = language == eng ? "ml" : language == rus ? "мл" : "ml";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
            ListTile(
              title:
                  Text(language == eng ? "gr" : language == rus ? "гр" : "gr"),
              onTap: () {
                dose = language == eng ? "gr" : language == rus ? "гр" : "gr";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
            ListTile(
              title:
                  Text(language == eng ? "mg" : language == rus ? "мг" : "mg"),
              onTap: () {
                dose = language == eng ? "mg" : language == rus ? "мг" : "mg";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
            ListTile(
              title: Text(language == eng
                  ? "Drops"
                  : language == rus ? "Капли" : "Tomchi"),
              onTap: () {
                dose = language == eng
                    ? "Drops"
                    : language == rus ? "Капли" : "Tomchi";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
            ListTile(
              title: Text(
                  language == eng ? "pc" : language == rus ? "шт" : "done"),
              onTap: () {
                dose = language == eng ? "pc" : language == rus ? "шт" : "done";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
            ListTile(
              title: Text(language == eng
                  ? "Tea spoon"
                  : language == rus ? "Чайная ложка" : "Choy qoshiq"),
              onTap: () {
                dose = language == eng
                    ? "Tea spoon"
                    : language == rus ? "Чайная ложка" : "Choy qoshiq";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
            ListTile(
              title: Text(language == eng
                  ? "Table spoon"
                  : language == rus ? "Столовая ложка" : "Osh qoshiq"),
              onTap: () {
                dose = language == eng
                    ? "Table spoon"
                    : language == rus ? "Столовая ложка" : "Osh qoshiq";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
            ListTile(
              title: Text(language == eng
                  ? "Package"
                  : language == rus ? "Упаковка" : "Paket"),
              onTap: () {
                dose = language == eng
                    ? "Package"
                    : language == rus ? "Упаковка" : "Paket";
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
