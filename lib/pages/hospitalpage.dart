import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/hospitalsmodel.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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

  // Future<http.Response> createReview() async {
  //   final response = await http.post(
  //       'http://medassistant-001-site1.itempurl.com/api/comment/createComment',
  //       // headers: {
  //       //   HttpHeaders.contentTypeHeader: 'application/json'
  //       // },
  //       body: );
  //   return response;
  // }

  test() async {
    final msg = jsonEncode({
      "HospitalId": 2,
      "UserName": "Fotima Khayrullaeva",
      "Comment1": "Test!"
    });

    final responce = await http.post(
        "http://medicalassistant-001-site1.dtempurl.com/api/reviewapi/post",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: msg);
    print(responce.body);
    print("response code" + responce.statusCode.toString());
  }

  Widget createTextbox() {
    if (addReview) {
      return Container(
          padding: EdgeInsets.only(top: 10.0),
          margin: EdgeInsets.only(bottom: 25.0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            // maxLines: 3,
            autofocus: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white12,
                //border: OutlineInputBorder(borderSide: BorderSide(width: .5)),
                hintText: language == eng
                    ? 'Review'
                    : language == rus ? "Отзыв" : "Izoh"),
            controller: _feedbackController,
          ));
    } else
      return Container();
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
        onTap: () {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addReview = !addReview;
            if (addReview) {
              test();
            }
            // if (addReview) {
            //   createReview().then((response) {
            //     if (response.statusCode == 200) {
            //       print("error on sending");
            //     } else {
            //       print('error on sending 2');
            //     }
            //   });
            // }
          });
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: addReview ? Icon(Icons.add_comment) : Icon(Icons.comment),
      ),
    );
  }
}
