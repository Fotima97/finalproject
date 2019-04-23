import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/usermodel.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FormPage extends StatefulWidget {
  FormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  double blankspace = 10.0;
  TextEditingController _fullnameController = new TextEditingController();
  TextEditingController _birthdateController = new TextEditingController();
  TextEditingController _allergiesController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  bool _checkboxValue = false;
  DateTime selectedDate = DateTime.now();

  List<DropdownMenuItem<String>> _dropdDownMenuItems;
  String _dropdownvalue;
  @override
  void initState() {
    super.initState();
    _dropdDownMenuItems = _getmenuitems();
    _dropdownvalue = _dropdDownMenuItems[0].value;
    checkConnectivity();
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

  createUser(User user) async {
    var userEncode = jsonEncode({
      "FullName": user.fullName,
      "Birthdate": user.birthDate,
      "Email": user.email,
      "BloodType": user.bloodType,
      "Allergies": user.allergies
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (_checkboxValue) {
      if (connectivity == ConnectivityResult.mobile ||
          connectivity == ConnectivityResult.wifi) {
        final responce = await http.post(
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
        print("response code" + responce.statusCode.toString());
      }
    } else {
      Flushbar(
        title : language == eng
            ? "Problems with connection"
            : language == rus
                ? "Проблемы с подключение"
                : "Ulanish bilan bog'liq muammolar",
        message : language == eng
            ? "Data is not uploaded to database"
            : language == rus
                ? "Данные не загружены в базу данных "
                : "Ma'lumotlar bazaga yuklanmadi",
        duration :Duration(seconds: 1),
        icon : Icon(
          Icons.info,
          color: Colors.white,
        ),
        backgroundColor: Colors.red)
        ..show(context);
    }
  }

  _saveUserData(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(userFullName, user.fullName);
    await DBProvider.db.createUser(user);
    createUser(user);
  }

  _setRegisterState(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(registered, value);
  }

  _setloginState(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(loginState, value);
  }

  String formDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CupertinoDatePicker(
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _birthdateController.text = formDate(value);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 40.0),
              Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Center(
                      child: Image.asset(
                    'assets/iconpng.png',
                    height: 50.0,
                    color: Colors.white,
                  )
                      // SvgPicture.asset(
                      //   'assets/icon.svg',
                      //   height: 50.0,
                      //   color: Colors.white,
                      // ),
                      )),
              Text(
                appName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              SizedBox(
                height: blankspace,
              ),
              Container(
                padding: EdgeInsets.all(25.0),
                child: Form(
                  key: _formkey,
                  child: new Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          Pattern pattern =
                              r'^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$';
                          RegExp regex = new RegExp(pattern);
                          if (value.isEmpty) {
                            return language == eng
                                ? 'Required field'
                                : language == rus
                                    ? "Обязательное поле"
                                    : "To'ldirilishi majburiy";
                          } else if (!regex.hasMatch(value)) {
                            return language == eng
                                ? 'Enter valid value'
                                : language == rus
                                    ? "Введите правильное значение"
                                    : "To'g'ri qiymat kiriting";
                          }
                        },
                        controller: _fullnameController,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFE2E4FB),
                          //focusedBorder: OutlineInputBorder(),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3.0)),
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          labelText: language == eng
                              ? 'Full name'
                              : language == rus ? "Полное имя" : "To'liq ismi",
                          hintText: language == eng
                              ? 'Khayrullaeva Fotima'
                              : language == rus
                                  ? "Хайруллаева Фотима"
                                  : "Khayrullaeva Fotima",
                        ),
                      ),
                      SizedBox(
                        height: blankspace,
                      ),
                      InkWell(
                        onTap: () {
                          _showDatePicker(context);
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: _birthdateController,
                          autofocus: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return language == eng
                                  ? 'Required field'
                                  : language == rus
                                      ? "Обязательное поле"
                                      : "To'ldirilishi majburiy";
                            }
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.red),
                              filled: true,
                              fillColor: Color(0xFFE2E4FB),
                              focusedBorder: OutlineInputBorder(),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 3.0)),
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              labelText: language == eng
                                  ? 'Birth date'
                                  : language == rus
                                      ? "День рождение"
                                      : "Tug'ilgan kun",
                              hintText: "01-10-1997"),
                        ),
                      ),
                      SizedBox(
                        height: blankspace,
                      ),
                      TextFormField(
                        validator: (value) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Enter Valid Email';
                          else
                            return null;
                        },
                        controller: _emailController,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFE2E4FB),
                          //focusedBorder: OutlineInputBorder(),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3.0)),
                          icon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          labelText: language == eng
                              ? 'Email'
                              : language == rus
                                  ? "Эл.адрес"
                                  : "Elektron pochta",
                          hintText: "mail@mail.ru",
                        ),
                      ),
                      SizedBox(
                        height: blankspace,
                      ),
                      FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 3.0)),
                              filled: true,
                              fillColor: Color(0xFFE2E4FB),
                              icon: Image.asset(
                                'assets/bloodpng.png',
                                height: 28.0,
                                color: Colors.white,
                              ),
                              labelText: language == eng
                                  ? 'Blood type'
                                  : language == rus
                                      ? "Группа крови"
                                      : "Qon guruhi",
                              hintText: language == eng
                                  ? 'O-positive'
                                  : language == rus
                                      ? "О-положительная"
                                      : "O-ijobiy",
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            isEmpty: _dropdownvalue == "",
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: _dropdDownMenuItems,
                                value: _dropdownvalue,
                                onChanged: (String v) {
                                  setState(() {
                                    _dropdownvalue = v;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: blankspace,
                      ),
                      TextFormField(
                        controller: _allergiesController,
                        autofocus: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFE2E4FB),
                            //focusedBorder: OutlineInputBorder(),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3.0)),
                            icon: Icon(
                              Icons.not_interested,
                              color: Colors.white,
                            ),
                            labelText: language == eng
                                ? 'Allergies'
                                : language == rus ? "Аллергии" : "Allergiyalar",
                            hintText: language == eng
                                ? 'Nut, cherry, honey'
                                : language == rus
                                    ? "Орех, вишня, мед"
                                    : "Yong'oq, gilos, asal"),
                      ),
                      SizedBox(
                        height: blankspace * 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: ListTile(
                          title: Text(
                            language == eng
                                ? "Add to online database"
                                : language == rus
                                    ? "Добавить в онлайн базу данных"
                                    : "Ma'lumotlar online bazasiga qo'shish",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Checkbox(
                            value: _checkboxValue,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              setState(() {
                                _checkboxValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: blankspace * 2,
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
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              height: 60.0,
                              minWidth: 300.0,
                              //color: greenColor,
                              child: Text(
                                language == eng
                                    ? 'Save'
                                    : language == rus ? "Сохранить" : "Saqlash",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  User user = new User(
                                      fullName: _fullnameController.text,
                                      birthDate: _birthdateController.text,
                                      bloodType: _dropdownvalue,
                                      allergies: _allergiesController.text,
                                      email: _emailController.text);
                                  _saveUserData(user);
                                  _setloginState(true);
                                  _setRegisterState(true);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/home', (Route<dynamic> route) => false);
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
