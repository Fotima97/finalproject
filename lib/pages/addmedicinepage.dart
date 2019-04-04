import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/medicationModel.dart';
import 'package:finalproject/helpers/reminderModel.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:finalproject/pages/medicinespage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

String dose = "";
bool newMedication = false;

class AddMedicine extends StatefulWidget {
  AddMedicine({Key key, this.action, this.medication, this.reminders})
      : super(key: key);
  final String action;
  final Medication medication;
  final List<Reminder> reminders;
  @override
  _AddMedicineState createState() => new _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  Color drugColor = Colors.blue;
  String selectedShape = circlepillShape;
  Color selectedColor = blueAccent;
  TextEditingController _doseController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  List<String> notifictionTime = new List<String>();
  TextEditingController notes = new TextEditingController();

  int duration;
  int _radioValue;
  bool _switchvalue = true;
  String alarmTime;
  String alarmTime1;
  String alarmTime2;
  String alarmTime3;

  void radioValueChanged(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  void _showDatePicker(BuildContext context, int id) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CupertinoDatePicker(
            onDateTimeChanged: (DateTime value) {
              setState(() {
                id == 1 ? startDate = value : endDate = value;
                duration = endDate.difference(startDate).inDays;
              });
            },
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            maximumYear: 2100,
            minimumYear: 1900,
          );
        });
  }

  String formTime(DateTime time) {
    return DateFormat("HH:mm").format(time);
  }

  String formDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _showTimeKeeper(BuildContext context, int id) {
    DatePicker.showTimePicker(context,
        showTitleActions: true, currentTime: DateTime.now(), onConfirm: (time) {
      setState(() {
        if (id == 0) {
          alarmTime = formTime(time);
        } else if (id == 1) {
          alarmTime1 = formTime(time);
        } else if (id == 2) {
          alarmTime2 = formTime(time);
        } else if (id == 3) {
          alarmTime3 = formTime(time);
        } else {
          alarmTime = formTime(time);
        }
      });
    });
  }

  void _onSwitchChange(bool value) {
    setState(() {
      _switchvalue = value;
    });
  }

  @override
  initState() {
    String currentTime = formTime(DateTime.now());

    if (widget.action == edit) {
      _nameController.text = widget.medication.medName;
      selectedShape = widget.medication.shape;
      selectedColor = Color(widget.medication.color);
      _doseController.text = widget.medication.dose.toString();
      dose = widget.medication.units;
      _radioValue = widget.medication.times - 1;
      duration = widget.medication.duration;
      startDate = DateTime.parse(widget.medication.startDate);
      endDate = DateTime.parse(widget.medication.endDate);
      notes.text = widget.medication.notes;
      switch (widget.reminders.length) {
        case 1:
          alarmTime = widget.reminders[0].notificationTime;
          alarmTime1 = currentTime;
          alarmTime2 = currentTime;
          alarmTime3 = currentTime;
          break;
        case 2:
          alarmTime = widget.reminders[0].notificationTime;
          alarmTime1 = widget.reminders[1].notificationTime;
          alarmTime2 = currentTime;
          alarmTime3 = currentTime;

          break;
        case 3:
          alarmTime = widget.reminders[0].notificationTime;
          alarmTime1 = widget.reminders[1].notificationTime;
          alarmTime2 = widget.reminders[2].notificationTime;
          alarmTime3 = currentTime;
          break;
        case 4:
          alarmTime = widget.reminders[0].notificationTime;
          alarmTime1 = widget.reminders[1].notificationTime;
          alarmTime2 = widget.reminders[2].notificationTime;
          alarmTime3 = widget.reminders[3].notificationTime;
          break;
        default:
      }
    } else {
      _doseController.text = "1";
      duration = endDate.compareTo(startDate);
      _switchvalue = true;
      _radioValue = 0;
      alarmTime = currentTime;
      alarmTime1 = currentTime;
      alarmTime2 = currentTime;
      alarmTime3 = currentTime;
    }

    super.initState();
  }

  Widget getPillShapes(String assetname) {
    Widget pillButton;
    pillButton = Material(
      borderRadius: BorderRadius.circular(10.0),
      color: selectedShape == assetname ? backgroundColor : Colors.white,
      child: MaterialButton(
        minWidth: 10.0,
        child: Image.asset(
          assetname,
          width: 25.0,
          height: 40.0,
          color: selectedShape == assetname ? drugColor : Colors.black,
        ),
        onPressed: () {
          setState(() {
            selectedShape = assetname;
          });
        },
      ),
    );

    return pillButton;
  }

  Widget drawCircle(Color color) {
    Widget circle;
    circle = Material(
      borderRadius: BorderRadius.circular(10.0),
      color: selectedColor == color ? backgroundColor : Colors.white,
      child: MaterialButton(
          splashColor: color.withOpacity(0.2),
          minWidth: 30.0,
          onPressed: () {
            setState(() {
              drugColor = color;
              selectedColor = color;
            });
          },
          child: Container(
            width: 25.0,
            height: 25.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: color),
          )),
    );

    return circle;
  }

  List<Widget> createNotificationcontrols(int number) {
    List<Widget> notifications = new List<Widget>();
    if (_switchvalue) {
      for (int i = 0; i < number; i++) {
        Widget widget = Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(language == eng
                      ? "Alarm time"
                      : language == rus ? "Время будильника" : "Signal vaqti"),
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.all(5.0),
                        width: 150.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.timer),
                            Text(
                              i == 0
                                  ? alarmTime
                                  : i == 1
                                      ? alarmTime1
                                      : i == 2
                                          ? alarmTime2
                                          : i == 3 ? alarmTime3 : alarmTime,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        )),
                    onTap: () {
                      _showTimeKeeper(context, i);
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        );
        notifications.add(widget);
      }
    }
    return notifications;
  }

  void addNotifications(int number) {
    if (_switchvalue) {
      switch (number) {
        case 0:
          notifictionTime.add(alarmTime);
          break;
        case 1:
          notifictionTime.add(alarmTime);
          notifictionTime.add(alarmTime1);
          break;
        case 2:
          notifictionTime.add(alarmTime);
          notifictionTime.add(alarmTime1);
          notifictionTime.add(alarmTime2);
          break;
        case 3:
          notifictionTime.add(alarmTime);
          notifictionTime.add(alarmTime1);
          notifictionTime.add(alarmTime2);
          notifictionTime.add(alarmTime3);

          break;
        default:
          notifictionTime = new List<String>();
      }
    }
  }

  String getTitle() {
    if (widget.action == edit) {
      return language == eng
          ? "Edit medicine"
          : language == rus ? "Редактировать лекарство" : "Dorini tahrirlash";
    } else {
      return language == eng
          ? "Add medicine"
          : language == rus ? "Добавить лекарство" : "Dori qo'shish";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
      ),
      body: SafeArea(
        child: Container(
          // color: Color(0xFFF5F6FD),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/pills.jpg"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black12, BlendMode.darken))),
          child: Container(
            // margin: EdgeInsets.only(
            //   right: 5.0,
            //   left: 5.0,
            //   top: 10.0,
            // ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ListView(
              primary: true,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              children: <Widget>[
                Text(
                  language == eng
                      ? "Name"
                      : language == rus ? "Название" : "Ismi",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: _nameController,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0))),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  language == eng
                      ? "How it looks?"
                      : language == rus
                          ? "Как оно выглядит"
                          : "Qanday korinishda?",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        height: 80.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            getPillShapes(circlepillShape),
                            getPillShapes(pillShape),
                            getPillShapes(heartShape),
                            getPillShapes(bottleShape),
                            getPillShapes(infusionShape),
                            getPillShapes(lotionShape),
                            getPillShapes(triangleShape),
                            getPillShapes(starShape),
                            getPillShapes(streamlineShape),
                            getPillShapes(pasteShape),
                          ],
                        ),
                      ),
                      //  Divider(),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        height: 80.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            drawCircle(blueAccent),
                            drawCircle(red),
                            drawCircle(orange),
                            drawCircle(purpleAccent),
                            drawCircle(cyan),
                            drawCircle(green),
                            drawCircle(brown),
                            drawCircle(indigo),
                            drawCircle(teal),
                            drawCircle(amber),
                            drawCircle(lime),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  language == eng ? "Dose" : language == rus ? "Доза" : "Doza",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _doseController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListTile(
                        title: Text(language == eng
                            ? "Units"
                            : language == rus ? "Единицы" : "Birliklari"),
                        trailing: Icon(Icons.chevron_right),
                        subtitle: Text("$dose"),
                        onTap: () {
                          Navigator.pushNamed(context, '/units');
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  language == eng ? "Times" : language == rus ? "Раз" : "Marta",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            groupValue: _radioValue,
                            value: 0,
                            onChanged: (int value) {
                              radioValueChanged(value);
                            },
                            activeColor: primaryColor,
                          ),
                          Text("1"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            groupValue: _radioValue,
                            value: 1,
                            onChanged: (int value) {
                              radioValueChanged(value);
                            },
                            activeColor: primaryColor,
                          ),
                          Text("2"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            groupValue: _radioValue,
                            value: 2,
                            onChanged: (int value) {
                              radioValueChanged(value);
                            },
                            activeColor: primaryColor,
                          ),
                          Text("3"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            groupValue: _radioValue,
                            value: 3,
                            onChanged: (int value) {
                              radioValueChanged(value);
                            },
                            activeColor: primaryColor,
                          ),
                          Text("4"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(language == eng
                              ? "Start Date"
                              : language == rus
                                  ? "Дата начала"
                                  : "Boshlanish kuni"),
                          InkWell(
                            child: Container(
                                padding: EdgeInsets.all(5.0),
                                width: 150.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(color: Colors.grey)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.today),
                                    Text(
                                      formDate(startDate),
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              _showDatePicker(context, 1);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(language == eng
                              ? "End Date"
                              : language == rus
                                  ? "Дата окончания"
                                  : "Tugash sanasi"),
                          InkWell(
                            child: Container(
                                padding: EdgeInsets.all(5.0),
                                width: 150.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(color: Colors.grey)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.today),
                                    Text(
                                      formDate(endDate),
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              _showDatePicker(context, 2);
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(language == eng
                              ? "Duration"
                              : language == rus
                                  ? "Продолжительность"
                                  : "Davomiyligi"),
                          Container(
                              width: 150.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    duration.toString(),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(language == eng
                                      ? "days"
                                      : language == rus ? "дней" : "kun")
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            language == eng
                                ? "Reminder"
                                : language == rus ? "Напоминание" : "Eslatma",
                          ),
                          Container(
                            width: 20.0,
                          ),
                          Container(
                            child: Switch(
                              value: _switchvalue,
                              onChanged: (bool value) {
                                _onSwitchChange(value);
                              },
                              activeColor: primaryColor,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: createNotificationcontrols(_radioValue + 1),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    language == eng
                        ? 'Notes'
                        : language == rus ? "Заметки" : "Izohlar",
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                ),
                TextField(
                  controller: notes,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(),
                ),
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
                  ? 'Save'
                  : language == rus ? "Сохранить" : "Saqlash",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        onTap: () async {
          addNotifications(_radioValue);

          if (widget.action == edit) {
            await DBProvider.db.updateMedication(new Medication(
                medId: widget.medication.medId,
                medName: _nameController.text,
                shape: selectedShape,
                color: selectedColor.value,
                dose: int.parse(_doseController.text),
                units: "$dose",
                times: _radioValue + 1,
                startDate: formDate(startDate),
                endDate: formDate(endDate),
                duration: duration,
                notes: notes.text));
            await DBProvider.db
                .getRemindersById(widget.medication.medId)
                .then((result) async {
              for (int i = 0; i < result.length; i++) {
                await DBProvider.db.deleteReminder(result[i].reminderId);
              }
            });
            for (int i = 0; i < notifictionTime.length; i++) {
              await DBProvider.db.addReminder(new Reminder(
                  medId: widget.medication.medId,
                  notificationTime: notifictionTime[i],
                  token: false));
            }
          } else {
            await DBProvider.db.addMedication(new Medication(
                medName: _nameController.text,
                shape: selectedShape,
                color: selectedColor.value,
                dose: int.parse(_doseController.text),
                units: "$dose",
                times: _radioValue + 1,
                startDate: formDate(startDate),
                endDate: formDate(endDate),
                duration: duration,
                notes: notes.text));

            for (int i = 0; i < notifictionTime.length; i++) {
              int id = await DBProvider.db.getLastMedicationId();
              await DBProvider.db.addReminder(new Reminder(
                  medId: id,
                  notificationTime: notifictionTime[i],
                  token: false));
            }
          }
          newMedication = true;

          Navigator.popUntil(context, (route) {
            return route.settings.name == "/medicines";
          });
        },
      ),
    );
  }
}
