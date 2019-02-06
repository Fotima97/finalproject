import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String dose = "";

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => new _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  Color drugColor = Colors.blue;
  int selectedDrug = 1;
  int selectedColor = 1;
  TextEditingController _doseController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  String duration;
  int _radioValue;
  bool _switchvalue = true;
  String alarmTime;

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
                duration = endDate.difference(startDate).inDays.toString();
              });
            },
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            maximumYear: 2100,
            minimumYear: 1900,
          );
        });
  }

  void _showTimeKeeper(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CupertinoTimerPicker(
            onTimerDurationChanged: (value) {
              setState(() {
                alarmTime = value.inHours.toString() +
                    ":" +
                    value.inMinutes.round().toString();
              });
            },
          );
        });
  }

  void _onSwitchChange(bool value) {
    setState(() {
      _switchvalue = value;
    });
  }

  @override
  initState() {
    duration = endDate.compareTo(startDate).toString();
    _switchvalue = true;
    _radioValue = 0;
    alarmTime = DateTime.now().hour.toString() +
        ":" +
        DateTime.now().minute.round().toString();

    super.initState();
  }

  Widget getPillShapes(String assetname, int id) {
    Widget pillButton;
    pillButton = Material(
      borderRadius: BorderRadius.circular(10.0),
      color: selectedDrug == id ? backgroundColor : Colors.white,
      child: MaterialButton(
        minWidth: 10.0,
        child: Image.asset(
          assetname,
          width: 25.0,
          height: 40.0,
          color: selectedDrug == id ? drugColor : Colors.black,
        ),
        onPressed: () {
          setState(() {
            selectedDrug = id;
          });
        },
      ),
    );

    return pillButton;
  }

  Widget drawCircle(Color color, int id) {
    Widget circle;
    circle = Material(
      borderRadius: BorderRadius.circular(10.0),
      color: selectedColor == id ? backgroundColor : Colors.white,
      child: MaterialButton(
          splashColor: color.withOpacity(0.2),
          minWidth: 30.0,
          onPressed: () {
            setState(() {
              drugColor = color;
              selectedColor = id;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Add medicine"
            : language == rus ? "Добавить лекарство" : "Dori qo'shish"),
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
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
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
                            getPillShapes('assets/circlepill.png', 1),
                            getPillShapes('assets/pill2.png', 2),
                            getPillShapes('assets/heart.png', 3),
                            getPillShapes('assets/bottle.png', 4),
                            getPillShapes('assets/infusion.png', 5),
                            getPillShapes('assets/lotion.png', 6),
                            getPillShapes('assets/triangle.png', 7),
                            getPillShapes('assets/star.png', 8),
                            getPillShapes('assets/streamline.png', 9),
                            getPillShapes('assets/paste.png', 10),
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
                            drawCircle(Colors.blueAccent, 1),
                            drawCircle(Colors.red, 2),
                            drawCircle(Colors.orange, 3),
                            drawCircle(Colors.purpleAccent, 4),
                            drawCircle(Colors.cyan, 5),
                            drawCircle(Colors.green, 6),
                            drawCircle(Colors.brown, 7),
                            drawCircle(Colors.indigo, 8),
                            drawCircle(Colors.teal, 9),
                            drawCircle(Colors.amber, 10),
                            drawCircle(Colors.lime, 11),
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
                        decoration: InputDecoration(hintText: "1"),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      startDate.day.toString() +
                                          "-" +
                                          startDate.month.toString() +
                                          "-" +
                                          startDate.year.toString(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      endDate.day.toString() +
                                          "-" +
                                          endDate.month.toString() +
                                          "-" +
                                          endDate.year.toString(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    duration,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(language == eng
                              ? "Alarm time"
                              : language == rus
                                  ? "Время будильника"
                                  : "Signal vaqti"),
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
                                    Icon(Icons.timer),
                                    Text(
                                      _switchvalue == true ? alarmTime : "",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              if (_switchvalue) {
                                _showTimeKeeper(context);
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                // Container(
                //   alignment: Alignment.center,
                //   child: Material(
                //     elevation: 5.0,
                //     borderRadius: BorderRadius.circular(30.0),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(6.0),
                //           color: accentColor),
                //       child: MaterialButton(
                //         shape: new RoundedRectangleBorder(
                //             borderRadius: new BorderRadius.circular(30.0)),
                //         height: 60.0,
                //         minWidth: 400.0,
                //         //color: greenColor,
                //         child: Text(
                //           language == eng
                //               ? 'Save'
                //               : language == rus ? "Сохранить" : "Saqlash",
                //           style: TextStyle(color: Colors.white, fontSize: 18.0),
                //         ),
                //         onPressed: () {
                //           Navigator.of(context).pushNamedAndRemoveUntil(
                //               '/home', (Route<dynamic> route) => false);
                //         },
                //       ),
                //     ),
                //   ),
                // )
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
        onTap: () {},
      ),
    );
  }
}
