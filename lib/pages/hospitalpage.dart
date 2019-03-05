import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/hospitalsmodel.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';

class HospitalPage extends StatefulWidget {
  _HospitalPageState createState() => new _HospitalPageState();
  HospitalPage({
    Key key,
    this.hospital,
  }) : super(key: key);
  final HospitalModel hospital;
}

class _HospitalPageState extends State<HospitalPage> {
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.hospital.imgUrl),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black45, BlendMode.darken))),
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
                  style: TextStyle(fontStyle: FontStyle.italic),
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
                            style: TextStyle(fontWeight: FontWeight.w600),
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
                        child: Text("No reviews"),
                      );
                    }
                  },
                )
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 60.0,
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
    );
  }
}
