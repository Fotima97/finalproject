import 'dart:async';
import 'dart:io';

import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/medicationModel.dart';
import 'package:finalproject/helpers/reminderModel.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:finalproject/pages/medicationdetail.dart';
import 'package:finalproject/pages/pillslist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayPills extends StatefulWidget {
  // PillsList({Key key, this.medications}) : super(key: key);

  // final List<Medication> medications;
  @override
  TodayPillsState createState() => TodayPillsState();
}

class TodayPillsState extends State<TodayPills> {
  List<Medication> medList = new List<Medication>();
  Future<Medication> getMedication(int id) async {
    return await DBProvider.db.getMedicationById(id);
  }

  updateReminder(Reminder reminder) async {
    await DBProvider.db.reminderToken(reminder);
  }

  Widget createCupertinoDialogBox(BuildContext context, String title, int dose,
      String units, Reminder reminder) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(dose.toString() + " " + units),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(
            language == eng
                ? "Cancel"
                : language == rus ? 'Отмена' : 'Bekor qilish',
          ),
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        ),
        CupertinoDialogAction(
          child: Text(language == eng
                  ? "Taken"
                  : language == rus ? "Принял" : "Qabul qildim"
              //  style: TextStyle(color: primaryColor),
              ),
          onPressed: () {
            updateReminder(reminder);
            setState(() {});

            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget createAndroidAlertBox(BuildContext context, String title, int dose,
      String units, Reminder reminder) {
    return AlertDialog(
      title: Text(title),
      content: Text(dose.toString() + " " + units),
      actions: <Widget>[
        FlatButton(
          child: Text(
            language == eng
                ? "Cancel"
                : language == rus ? 'Отмена' : 'Bekor qilish',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(language == eng
              ? "Taken"
              : language == rus ? "Принял" : "Qabul qildim"),
          onPressed: () {
            updateReminder(reminder);
            setState(() {});
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  getAllMedications() async {
    await DBProvider.db.getAllMedications().then((result) {
      medList = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllMedications();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: FutureBuilder<List<Reminder>>(
      future: DBProvider.db.getnotTokenReminders(),
      builder: (BuildContext context, AsyncSnapshot<List<Reminder>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Reminder reminder = snapshot.data[index];
                Medication medication =
                    medList.singleWhere((m) => m.medId == reminder.medId);

                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        medication.medId == null ? pillShape : medication.shape,
                        width: 25.0,
                        height: 40.0,
                        color: Color(medication.medId == null
                            ? green
                            : medication.color),
                      ),
                      title: Text(medication.medName),
                      subtitle: Text(
                          medication.dose.toString() + " " + medication.units),
                      trailing: Text(reminder.notificationTime),
                      onTap: () {
                        if (Platform.isAndroid) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return createAndroidAlertBox(
                                    context,
                                    medication.medName,
                                    medication.dose,
                                    medication.units,
                                    reminder);
                                ;
                              });
                        } else {
                          showDialog(
                              context: context,
                              child: createCupertinoDialogBox(
                                  context,
                                  medication.medName,
                                  medication.dose,
                                  medication.units,
                                  reminder));
                        }
                      },
                    ),
                    Divider()
                  ],
                );
              },
            );
          } else {
            return Center(
                child: Text(
              language == eng
                  ? "No data"
                  : language == rus ? "Нет данных" : "Ma'lumotlar yoq",
              style: TextStyle(color: Colors.grey),
            ));
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: primaryColor,
          ));
        }
      },
    ));
  }
}
