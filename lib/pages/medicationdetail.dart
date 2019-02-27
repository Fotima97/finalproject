import 'dart:io';

import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/medicationModel.dart';
import 'package:finalproject/helpers/reminderModel.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicationDetails extends StatefulWidget {
  MedicationDetails({Key key, this.medication, this.status, this.reminder})
      : super(key: key);

  final String status;
  final Medication medication;
  final Future<List<Reminder>> reminder;

  @override
  MedicationDetailsState createState() => MedicationDetailsState();
}

class MedicationDetailsState extends State<MedicationDetails> {
  List<Reminder> rems = new List<Reminder>();

  deleteMedication(BuildContext context) async {
    await DBProvider.db.deleteMedication(widget.medication.medId);
    Navigator.popUntil(context, (route) {
      return route.settings.name == "/medicines";
    });
  }

  Widget createCupertinoDialogBox(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(language == eng
          ? "Delete"
          : language == rus ? "Удалить" : "O'chirish"),
      content: Text(language == eng
          ? "Are you sure to delete this medication?"
          : language == rus
              ? "Вы уверены, что хотите удалить это лекарство?"
              : "Ushbu dorini o'chirib tashlashga aminmisiz?"),
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
          child: Text(language == eng ? "Yes" : language == rus ? "Да" : "Ha"
              //  style: TextStyle(color: primaryColor),
              ),
          onPressed: () {
            deleteMedication(context);
          },
        )
      ],
    );
  }

  Widget createAndroidAlertBox(BuildContext context) {
    return AlertDialog(
      title: Text(language == eng
          ? "Delete"
          : language == rus ? "Удалить" : "O'chirish"),
      content: Text(language == eng
          ? "Are you sure to delete this medication?"
          : language == rus
              ? "Вы уверены, что хотите удалить это лекарство?"
              : "Ushbu dorini o'chirib tashlashga aminmisiz?"),
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
          child: Text(language == eng ? "Yes" : language == rus ? "Да" : "Ha"),
          onPressed: () {
            deleteMedication(context);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Medication"
            : language == rus ? "Лекарство" : "Dori vositasi"),
      ),
      body: Container(
        color: backgroundColor,
        height: 600.0,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Center(
                    child: Text(
                  widget.medication.medName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                )),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          language == eng
                              ? "Status"
                              : language == rus ? "Статус" : "Status",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.status,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                          language == eng
                              ? "Start date"
                              : language == rus
                                  ? "Дата начала"
                                  : "Boshlanish vaqti",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.today,
                              color: primaryColor,
                            ),
                            Text(
                              widget.medication.startDate,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                          language == eng
                              ? "End date"
                              : language == rus
                                  ? "Дата окончания"
                                  : "Tugash sanasi",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.today,
                              color: primaryColor,
                            ),
                            Text(
                              widget.medication.endDate,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                            language == eng
                                ? "Notes"
                                : language == rus ? "Заметки" : "Izohlar",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.medication.notes,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                FutureBuilder(
                  future: widget.reminder,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Reminder reminder = snapshot.data[index];
                            rems = snapshot.data;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          language == eng
                                              ? "Alarm time"
                                              : language == rus
                                                  ? "Время будильника"
                                                  : "Signal vaqti",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(reminder.notificationTime,
                                            textAlign: TextAlign.right),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 60.0,
          color: accentColor,
          child: Center(
            child: Text(
              language == eng
                  ? 'Delete'
                  : language == rus ? "Удалить" : "O'chirish",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        onTap: () async {
          if (Platform.isAndroid) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return createAndroidAlertBox(context);
                });
          } else {
            showDialog(
                context: context, child: createCupertinoDialogBox(context));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddMedicine(
                        action: edit,
                        medication: widget.medication,
                        reminders: rems,
                      )));
        },
      ),
    );
  }
}
