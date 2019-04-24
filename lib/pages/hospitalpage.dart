import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/hospitalsmodel.dart';
import 'package:finalproject/pages/map.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalPage extends StatefulWidget {
  _HospitalPageState createState() => new _HospitalPageState();
  HospitalPage({
    Key key,
    this.hospital,
  }) : super(key: key);
  final HospitalModel hospital;
}

class _HospitalPageState extends State<HospitalPage> {
  TextEditingController _feedbackController = new TextEditingController();
  bool addReview = false;
  String userName;
  bool onlineRegistred;
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(userFullName) != null) {
      userName = preferences.getString(userFullName);
    }
  }

  getUserStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(onlineSaved) != null) {
      onlineRegistred = preferences.getBool(onlineSaved);
    } else {
      onlineRegistred = false;
    }
  }

  Future<http.Response> createReview() async {
    http.Response response;
    var msg = jsonEncode({
      "HospitalId": widget.hospital.hospitalId,
      "UserName": userName,
      "Comment1": _feedbackController.text
    });
    if (connectivity == ConnectivityResult.mobile ||
        connectivity == ConnectivityResult.wifi) {
      if (_formkey.currentState.validate()) {
        response = await http.post(
            "http://medicalassistant-001-site1.dtempurl.com/api/reviewapi/post",
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json"
            },
            body: msg);
        return response;
      } else {
        Flushbar(
            title: language == eng
                ? 'Error'
                : language == rus ? "Ошибка" : "Xatolik",
            message: language == eng
                ? 'You cannot post empty review'
                : language == rus
                    ? "Вы не можете оставить пустой отзыв"
                    : "Siz bo'sh ko'rib chiqishni yubora olmaysiz",
            duration: Duration(seconds: 3),
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            backgroundColor: Colors.red)
          ..show(context);
        return null;
      }
    } else {
      Flushbar(
          title: language == eng
              ? "Problems with internet connection"
              : language == rus
                  ? "Проблемы с подключением к сети"
                  : "Internetga ulanish bilan muamolar",
          message: language == eng
              ? "Check network connectivity"
              : language == rus
                  ? "Проверьте подключение к сети"
                  : "Tarmoqga ulanishini tekshiring",
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          backgroundColor: Colors.red)
        ..show(context);
      return null;
    }
  }

  @override
  initState() {
    super.initState();
    getUserStatus();
    getUserName();
    checkConnectivity();
  }

  Widget createTextbox() {
    _feedbackController.clear();

    if (addReview) {
      if (onlineRegistred) {
        return Container(
            padding: EdgeInsets.only(top: 10.0),
            margin: EdgeInsets.only(bottom: 25.0),
            child: Form(
              key: _formkey,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                // maxLines: 3,
                validator: (value) {
                  if (value.isEmpty) {
                    return language == eng
                        ? 'You cannot post empty review'
                        : language == rus
                            ? "Вы не можете оставить пустой отзыв"
                            : "Siz bo'sh ko'rib chiqishni yubora olmaysiz";
                  }
                },
                autofocus: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white12,
                    //border: OutlineInputBorder(borderSide: BorderSide(width: .5)),
                    hintText: language == eng
                        ? 'Review'
                        : language == rus ? "Отзыв" : "Izoh"),
                controller: _feedbackController,
              ),
            ));
      } else {
        Flushbar(
            title: language == eng
                ? "You are not registered online"
                : language == rus
                    ? "Вы не зарегистрированы онлайн"
                    : "Siz onlayn ro'yxatdan o'tmagansiz",
            message: language == eng
                ? "Please register online"
                : language == rus
                    ? " Пожалуйста пройдите онлайн регистрацию"
                    : "Iltimos,onlaynda ro'yxatdan o'ting",
            duration: Duration(seconds: 3),
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            backgroundColor: Colors.red)
          ..show(context);
        return Container();
      }
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.hospital.title,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Container(
            height: 200.0,
            child: FadeInImage.memoryNetwork(
              image: widget.hospital.imgUrl,
              placeholder:
                  kTransparentImage, // new AssetImage('assets/hospital.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  widget.hospital.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.hospital.description,
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Text(
                          language == eng
                              ? "Phone number"
                              : language == rus
                                  ? "Телефон номар"
                                  : "Telefon raqam",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          widget.hospital.phoneNumber,
                          textAlign: TextAlign.right,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Text(
                          language == eng
                              ? "Address"
                              : language == rus ? "Адрес" : "Manzil",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          widget.hospital.address,
                          textAlign: TextAlign.right,
                        ))
                  ],
                ),
                Divider(
                  height: 15.0,
                  color: Colors.black,
                ),
                Text(
                  language == eng
                      ? "Reviews"
                      : language == rus ? "Отзывы" : "Izohlar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.hospital.reviews.length,
                  itemBuilder: (context, index) {
                    if (widget.hospital.reviews.length > 0) {
                      var review = widget.hospital.reviews[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            review.userName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            review.review,
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(language == eng
                            ? "No reviews"
                            : language == rus ? "Нет отзывов" : "izoh yoq"),
                      );
                    }
                  },
                ),
                createTextbox()
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 55.0,
          color: accentColor,
          child: Center(
            child: Text(
              language == eng
                  ? "Find in Map"
                  : language == rus ? "Найти на карте" : "Karta",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Map(
                        hospital: widget.hospital,
                      )));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addReview = !addReview;

            if (!addReview) {
              createReview().then((response) {
                if (response != null) {
                  if (response.statusCode == 200) {
                    Flushbar(
                        title: language == eng
                            ? "Successfully added"
                            : language == rus
                                ? "Успешно добавлено"
                                : "Muvaffaqiyatli qo'shildi",
                        message: language == eng
                            ? "Review is added to database"
                            : language == rus
                                ? "Отзыв добавлен в базу данных"
                                : "Ko'rib chiqish bazasiga qo'shilgan",
                        duration: Duration(seconds: 3),
                        icon: Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green)
                      ..show(context);
                  }
                }
              });
            }
          });
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: addReview ? Icon(Icons.add_comment) : Icon(Icons.comment),
      ),
    );
  }
}
