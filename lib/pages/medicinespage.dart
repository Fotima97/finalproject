import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/medicationModel.dart';
import 'package:finalproject/helpers/reminderModel.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:finalproject/pages/pillslist.dart';
import 'package:finalproject/pages/todayspills.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicinesPage extends StatefulWidget {
  MedicinesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  int numberodPills;
  //int _currentIndex;
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;
  List<Reminder> notTokenReminders = new List<Reminder>();
  List<Medication> expiredMedications = new List<Medication>();
  bool notifStatus = true;
  @override
  void dispose() {
    super.dispose();
    getRemindersforNotification();
    getExpiredNotifications();
  }

  getNotificationPermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(notificationsStatus) != null) {
      notifStatus = preferences.getBool(notificationsStatus);
    } else {
      notifStatus = true;
    }
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    getData();
  }

  Future onSelectNotification(String payload) async {
    Navigator.pushNamed(context, '/medicines');
  }

  _showNotifications() async {
    await flutterLocalNotificationPlugin.cancelAll();
    List<Time> scheduldeTime = List<Time>();

    for (int i = 0; i < notTokenReminders.length; i++) {
      String s = notTokenReminders[i].notificationTime;
      TimeOfDay t = TimeOfDay(
          hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));

      scheduldeTime.add(Time(t.hour, t.minute));
    }
    //var time = new Time(10, 25, 0);
    for (int i = 0; i < scheduldeTime.length; i++) {
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'repeatDailyAtTime channel id $i',
          'repeatDailyAtTime channel name $i',
          'repeatDailyAtTime description $i');

      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      var platformChannelSpecifics = new NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationPlugin.showDailyAtTime(
          notTokenReminders[i].medId,
          'Med Assistant',
          'Time to take your medication',
          scheduldeTime[i],
          platformChannelSpecifics);
    }
  }

  cancelNotifications() async {
    for (int i = 0; i < expiredMedications.length; i++) {
      await flutterLocalNotificationPlugin.cancel(expiredMedications[i].medId);
    }
  }

  getExpiredNotifications() async {
    await DBProvider.db.getMedicationsByEndDate().then((result) {
      expiredMedications = result;
    });
    cancelNotifications();
  }

  getRemindersforNotification() async {
    await DBProvider.db.getnotTokenReminders().then((result) {
      notTokenReminders = result;
      if (notifStatus) {
        _showNotifications();
      }
    });
  }

  getData() async {
    await DBProvider.db.getAllMedications();
  }

  void onTabTapped(int index) {
    setState(() {
      medicationIndex = index;
    });
  }

  List<Widget> createTabs() {
    return [TodayPills(), PillsList()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Medications"
            : language == rus ? "Лекарства" : "Dori vositalari"),
      ),
      body: SafeArea(child: createTabs()[medicationIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: medicationIndex,
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
