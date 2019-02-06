import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController _fullname = new TextEditingController();
  TextEditingController _birthdate = new TextEditingController();
  TextEditingController _allergies = new TextEditingController();
  List<DropdownMenuItem<String>> _dropdDownMenuItems;
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  String _bloodtype;
  _getProfilevalues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(userFullName) != null) {
      _fullname.text = preferences.getString(userFullName);
      fullname = preferences.getString(userFullName);
    } else {
      _fullname.text = "";
    }
    if (preferences.getString(userBirthDate) != null) {
      _birthdate.text = preferences.getString(userBirthDate);
      birthdate = preferences.getString(userBirthDate);
    } else {
      _birthdate.text = "";
    }
    if (preferences.getString(userBloodType) != null) {
      _bloodtype = preferences.getString(userBloodType);
      bloodtype = preferences.getString(userBloodType);
    } else {
      _bloodtype = _dropdDownMenuItems[0].value;
    }
    if (preferences.getString(userAllergies) != null) {
      _allergies.text = preferences.getString(userAllergies);
      allergise = preferences.getString(userAllergies);
    } else {
      _allergies.text = "";
    }
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

  _saveUserData(String fullname, String birthdate, String bloodtype,
      String allergies) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(userFullName, fullname);
    preferences.setString(userBirthDate, birthdate);
    preferences.setString(userBloodType, bloodtype);
    preferences.setString(userAllergies, allergies);
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CupertinoDatePicker(
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _birthdate.text = value.day.toString() +
                    "-" +
                    value.month.toString() +
                    "-" +
                    value.year.toString();
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
                        _saveUserData(_fullname.text, _birthdate.text,
                            _bloodtype, _allergies.text);
                        _getProfilevalues();
                        Navigator.of(context).pushReplacementNamed("/profile");
                        Navigator.of(context).pop();
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
