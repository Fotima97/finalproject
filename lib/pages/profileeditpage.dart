import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/usermodel.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

User updateUser;
bool update = false;

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key key, this.user}) : super(key: key);

  final User user;
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController _fullname = new TextEditingController();
  TextEditingController _birthdate = new TextEditingController();
  TextEditingController _allergies = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  List<DropdownMenuItem<String>> _dropdDownMenuItems;
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  bool _checkboxValue = false;
  String _bloodtype;
  _getProfilevalues() async {
    _fullname.text = widget.user.fullName;
    _birthdate.text = widget.user.birthDate;
    _allergies.text = widget.user.allergies;
    _email.text = widget.user.email;
  }

  String formDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  List<DropdownMenuItem<String>> _getmenuitems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(DropdownMenuItem(
      child: Text(
        language == eng
            ? "I-positive"
            : language == rus ? "I-положительное" : "I-ijobiy",
      ),
      value: i1,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        language == eng
            ? "I-negative"
            : language == rus ? "I-отрицательное" : "I-salbiy",
      ),
      value: i2,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        language == eng
            ? "II-positive"
            : language == rus ? "II-положительное" : "II-ijobiy",
      ),
      value: o1,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        language == eng
            ? "II-negative"
            : language == rus ? "II-отрицательное" : "II-salbiy",
      ),
      value: o2,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        language == eng
            ? "III-positive"
            : language == rus ? "III-положительное" : "III-ijobiy",
      ),
      value: b1,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        language == eng
            ? "III-negative"
            : language == rus ? "III-отрицательное" : "III-salbiy",
      ),
      value: b2,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        language == eng
            ? "IV-positive"
            : language == rus ? "IV-положительное" : "IV-ijobiy",
      ),
      value: c1,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        language == eng
            ? "IV-negative"
            : language == rus ? "IV-отрицательное" : "IV-salbiy",
      ),
      value: c2,
    ));

    return items;
  }

  _saveUserData(User user) async {
    var userEncode = jsonEncode({
      "FullName": user.fullName,
      "Birthdate": user.birthDate,
      "Email": user.email,
      "BloodType": user.bloodType,
      "Allergies": user.allergies
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(userFullName, user.fullName);
    updateUser = user;
    await DBProvider.db.updateUser(updateUser);
    if (_checkboxValue) {
      if (connectivity == ConnectivityResult.mobile ||
          connectivity == ConnectivityResult.wifi) {
        final responce = await http.put(
            "http://medicalassistant-001-site1.dtempurl.com/api/userapi/post",
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json"
            },
            body: userEncode);
        print(responce.body);
        if (responce.statusCode == 200) {
          preferences.setBool(onlineSaved, true);
        }
      } else {
        Flushbar()
          ..title = language == eng
              ? "Problems with connection"
              : language == rus
                  ? "Проблемы с подключение"
                  : "Ulanish bilan bog'liq muammolar"
          ..message = language == eng
              ? "Data is not uploaded to database"
              : language == rus
                  ? "Данные не загружены в базу данных "
                  : "Ma'lumotlar bazaga yuklanmadi"
          ..duration = Duration(seconds: 1)
          ..icon = Icon(
            Icons.info,
            color: Colors.white,
          )
          ..backgroundColor = Colors.red
          ..show(context);
      }
    }
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CupertinoDatePicker(
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _birthdate.text = formDate(value);
              });
            },
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            maximumYear: DateTime.now().year,
            minimumYear: 1900,
          );
        });
  }

  @override
  void initState() {
    _getProfilevalues();
    checkConnectivity();
    _dropdDownMenuItems = _getmenuitems();
    _bloodtype = _dropdDownMenuItems[0].value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Edit profile"
            : language == rus
                ? "Редактировать профиль"
                : "Profilni tahrirlash"),
      ),
      body: SafeArea(
        child: Container(
            child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              TextField(
                controller: _fullname,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  labelText: language == eng
                      ? 'Full name'
                      : language == rus ? "Полное имя" : "To'liq ismi",
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  _showDatePicker(context);
                },
                child: TextFormField(
                  enabled: false,
                  controller: _birthdate,
                  autofocus: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                    labelText: language == eng
                        ? 'Birth date'
                        : language == rus ? "День рождение" : "Tug'ilgan kun",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (value) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (value.isNotEmpty && !regex.hasMatch(value))
                    return 'Enter Valid Email';
                  else
                    return null;
                },
                controller: _email,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  labelText: language == eng
                      ? 'Email'
                      : language == rus ? "Эл.адрес" : "Elektron pochta",
                  hintText: "mail@mail.ru",
                ),
              ),
              SizedBox(height: 20.0),
              InputDecorator(
                decoration: InputDecoration(
                  icon: Image.asset('assets/bloodpng.png', height: 28.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items: _dropdDownMenuItems,
                    value: _bloodtype,
                    onChanged: (String value) {
                      setState(() {
                        _bloodtype = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _allergies,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.not_interested,
                    color: Colors.black,
                  ),
                  labelText: language == eng
                      ? 'Allergies'
                      : language == rus ? "Аллергии" : "Allergiyalar",
                ),
              ),
              SizedBox(height: 40.0),
              ListTile(
                title: Text(language == eng
                    ? "Add to database"
                    : language == rus
                        ? "Добавить в базу данных"
                        : "Ma'lumotlar bazasiga qo'shish"),
                trailing: Checkbox(
                  value: _checkboxValue,
                  onChanged: (value) {
                    setState(() {
                      _checkboxValue = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(left: 40.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: greenColor),
                    child: MaterialButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      height: 60.0,
                      minWidth: 300.0,
                      //color: greenColor,
                      child: Text(
                        language == eng
                            ? 'Save'
                            : language == rus ? "Сохранить" : "Saqlash",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          User user = new User(
                              fullName: _fullname.text,
                              birthDate: _birthdate.text,
                              bloodType: _bloodtype,
                              allergies: _allergies.text,
                              email: _email.text);
                          _saveUserData(user);
                          //  _getProfilevalues();
                          // Navigator.of(context)
                          //     .pushReplacementNamed("/profile");
                          update = true;
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
