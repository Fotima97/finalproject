import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/medicationModel.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:finalproject/pages/pillslist.dart';
import 'package:finalproject/pages/todayspills.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicinesPage extends StatefulWidget {
  MedicinesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  int numberodPills;
  int _currentIndex;
  @override
  void initState() {
    super.initState();
    getData();
    _currentIndex = 0;
  }

  getData() async {
    await DBProvider.db.getAllMedications();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [TodayPills(), PillsList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Medications"
            : language == rus ? "Лекарства" : "Dori vositalari"),
      ),
      body: SafeArea(child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.today),
            title: Text(language == eng
                ? "Scheduled for today"
                : language == rus
                    ? "Запланировано на сегодня"
                    : "Bugungi kunda rejalashtirilgan"),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text(language == eng
                ? "Medicines"
                : language == rus ? "Лекарства" : "Dorilar"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: accentColor,
        onPressed: () {
          Navigator.pushNamed(context, '/medicineadd');
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
