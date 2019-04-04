import 'dart:convert';
import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/hospitalsmodel.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/hospitalpage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HospitalsPage extends StatefulWidget {
  _HospitalsPageState createState() => new _HospitalsPageState();
}

class _HospitalsPageState extends State<HospitalsPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int _selectedTab = 0;
  var dir;
  var jsonFile;
  var fileExists;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
    tabController = new TabController(vsync: this, length: 3);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTab = tabController.index;
    });
  }

  Future<List<HospitalModel>> _getHospitalsJsonFromPhoneStorage() async {
    var _hospitalJson;

    Directory directory = await getApplicationDocumentsDirectory();
    dir = directory;
    String path = language == eng
        ? "/hospitalsen.json"
        : language == rus ? "/hospitalsenru.json" : "/hospitalsenuz.json";
    jsonFile = new File(dir.path + path);
    fileExists = jsonFile.existsSync();

    if (fileExists) {
      _hospitalJson = jsonFile.readAsStringSync();
      return parseHospitals(_hospitalJson);
    } else {
      Flushbar()
        ..title = "Проблемы с сервером"
        ..message = "Проверьте подключение к сети"
        ..duration = Duration(seconds: 1)
        ..icon = Icon(
          Icons.info,
          color: Colors.white,
        )
        ..backgroundColor = Colors.red
        ..show(context);
      return null;
    }
  }

  void _saveJsonToFileSystem(String fileName, String content) {
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      String path = language == eng
          ? "/hospitalsen"
          : language == rus ? "/hospitalsenru" : "/hospitalsenuz";
      jsonFile = new File(dir.path + path + fileName);
      fileExists = jsonFile.existsSync();
      jsonFile.writeAsStringSync(content);
    });
  }

  List<HospitalModel> parseHospitals(String responseBody) {
    final parsed = json.decode(responseBody);
    var jsonData;
    jsonData = (parsed).cast<Map<String, dynamic>>();

    return jsonData
        .map<HospitalModel>((json) => HospitalModel.fromJson(json))
        .toList();
  }

  Future<List<HospitalModel>> fetchHospitals() async {
    var client = http.Client();
    if (connectivity == ConnectivityResult.mobile ||
        connectivity == ConnectivityResult.wifi) {
      final response = await client.get(language == eng
          ? 'http://medicalassistant-001-site1.dtempurl.com/api/hospitalapi/eng'
          : language == rus
              ? 'http://medicalassistant-001-site1.dtempurl.com/api/hospitalapi/ru'
              : 'http://medicalassistant-001-site1.dtempurl.com/api/hospitalapi/uz');

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        if (language == eng) {
          _saveJsonToFileSystem('hospitalsen.json', body);
        } else if (language == rus) {
          _saveJsonToFileSystem('hospitalsru.json', body);
        } else {
          _saveJsonToFileSystem('hospitalsuz.json', body);
        }
        return parseHospitals(body);
      } else {
        return _getHospitalsJsonFromPhoneStorage();
      }
    } else {
      return _getHospitalsJsonFromPhoneStorage();
    }
  }

  @override
  dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget createHospitalRow(HospitalModel hospital, List<Review> reviewslist) {
    return Material(
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HospitalPage(
                        hospital: hospital,
                      )));
        },
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(hospital.title),
              subtitle: Text(
                hospital.address,
                style: TextStyle(fontSize: 11.0),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    reviewslist.length.toString(),
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    language == eng
                        ? "reviews"
                        : language == rus ? "отзывы" : "izohlar",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  Widget createTabContent(int categoryId, List<HospitalModel> hospitals) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 20.0),
      itemCount: hospitals.length,
      itemBuilder: (context, index) {
        var hospital = hospitals[index];
        var reviewslist = hospitals[index].reviews;
        if (hospital.categoryId == categoryId) {
          return createHospitalRow(hospital, reviewslist);
        } else if (categoryId == 3) {
          return createHospitalRow(hospital, reviewslist);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          MaterialButton(
            minWidth: 30.0,
            child: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        title: Text(language == eng
            ? "Hospitals"
            : language == rus ? "Больницы" : "Shifoxonalar"),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(
              text:
                  language == eng ? "All" : language == rus ? "Все" : "Hammasi",
            ),
            Tab(
              text: language == eng
                  ? "Governmental"
                  : language == rus ? "Государственные" : "Davlat",
            ),
            Tab(
              text: language == eng
                  ? "Private"
                  : language == rus ? "Частные" : "Xusisiy",
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: FutureBuilder<List<HospitalModel>>(
        future: fetchHospitals(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<HospitalModel> hospitals = snapshot.data;
            return TabBarView(
              controller: tabController,
              children: <Widget>[
                createTabContent(3, hospitals),
                createTabContent(1, hospitals),
                createTabContent(2, hospitals),
              ],
            );

            //  ListView.builder(
            //   itemCount: snapshot.data.length,
            //   itemBuilder: (context, index) {
            //     var hospital = snapshot.data[index];
            //     return ListTile(
            //       title: Text(hospital.title),
            //     );
            //   },
            // );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
          //     TabBarView(
          //   controller: tabController,
          //   children: <Widget>[
          //     createTabContent("all"),
          //     createTabContent("government"),
          //     createTabContent("private"),
          //   ],
          // )
          ),
    );
  }
}
