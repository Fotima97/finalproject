import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';

class NewsMorePage extends StatefulWidget {
  NewsMorePage({Key key, this.title, this.news, this.date, this.imageurl})
      : super(key: key);

  final String title;
  final String news;
  final String imageurl;
  final String date;
  _NewsMorePageState createState() => new _NewsMorePageState();
}

class _NewsMorePageState extends State<NewsMorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "News"
            : language == rus ? "Новости" : "Янгиликлар"),
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Container(
            height: 220.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: widget.imageurl == ""
                        ? AssetImage('assets/news.jpg')
                        : NetworkImage(widget.imageurl),
                    fit: BoxFit.cover)),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.news,
                  style: TextStyle(),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
