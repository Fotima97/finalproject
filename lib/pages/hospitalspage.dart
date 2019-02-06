import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/hospitalsmodel.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/hospitalpage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';

class HospitalsPage extends StatefulWidget {
  _HospitalsPageState createState() => new _HospitalsPageState();
}

class _HospitalsPageState extends State<HospitalsPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int _selectedTab = 0;
  List<HospitalModel> hospitals = new List<HospitalModel>();
  List<Review> reviews = new List<Review>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(vsync: this, length: 3);
    tabController.addListener(_handleTabSelection);
    _createList();
  }

  _createList() {
    reviews.add(Review(userName: "Sam", review: "Review 1"));
    reviews.add(Review(userName: "Dan", review: "Review 2"));
    reviews.add(Review(userName: "Sam", review: "Review 1"));
    reviews.add(Review(userName: "Dan", review: "Review 2"));
    hospitals.add(HospitalModel(
        title: "SHOX INTERNATIONAL HOSPITAL",
        description:
            "Частная многопрофильная клиника, рассчитанная на 20 стационарных больных, а также оказания медицинской помощи 120 амбулаторным больным в день. ",
        phoneNumber: "+998 71 202-02-12",
        address: "Республика Узбекистан,г. Ташкент, 100015 улица Ойбека, 34.",
        category: "private",
        lat: 41.2922589,
        long: 69.2769942,
        reviews: reviews,
        imgUrl: "http://mku.uz/logo/461.jpg"));
    hospitals.add(HospitalModel(
        title: "'НУРОНИЙ' СТАЦИОНАР",
        description: " ",
        phoneNumber: "+998 71 2915623",
        address:
            "Республика Узбекистан,г. Ташкент,Яшнабадский туп. 1-й ОШСКОЙ, 6А",
        category: "government",
        lat: 41.2922589,
        long: 69.2769942,
        imgUrl: "",
        reviews: List<Review>()));

    hospitals.add(HospitalModel(
        title: "SHOX INTERNATIONAL HOSPITAL",
        description:
            "Частная многопрофильная клиника, рассчитанная на 20 стационарных больных, а также оказания медицинской помощи 120 амбулаторным больным в день. ",
        phoneNumber: "+998 71 202-02-12",
        address: "Республика Узбекистан,г. Ташкент, 100015 улица Ойбека, 34.",
        category: "private",
        lat: 41.2922589,
        long: 69.2769942,
        reviews: reviews,
        imgUrl: "http://mku.uz/logo/461.jpg"));
    hospitals.add(HospitalModel(
        title: "'НУРОНИЙ' СТАЦИОНАР",
        description: " ",
        phoneNumber: "+998 71 2915623",
        address:
            "Республика Узбекистан,г. Ташкент,Яшнабадский туп. 1-й ОШСКОЙ, 6А",
        category: "government",
        imgUrl: "",
        lat: 41.2922589,
        long: 69.2769942,
        reviews: List<Review>()));

    hospitals.add(HospitalModel(
        title: "SHOX INTERNATIONAL HOSPITAL",
        description:
            "Частная многопрофильная клиника, рассчитанная на 20 стационарных больных, а также оказания медицинской помощи 120 амбулаторным больным в день. ",
        phoneNumber: "+998 71 202-02-12",
        address: "Республика Узбекистан,г. Ташкент, 100015 улица Ойбека, 34.",
        category: "private",
        lat: 41.2922589,
        long: 69.2769942,
        reviews: reviews,
        imgUrl: "http://mku.uz/logo/461.jpg"));
    hospitals.add(HospitalModel(
        title: "'НУРОНИЙ' СТАЦИОНАР",
        description: " ",
        imgUrl: "",
        phoneNumber: "+998 71 2915623",
        address:
            "Республика Узбекистан,г. Ташкент,Яшнабадский туп. 1-й ОШСКОЙ, 6А",
        category: "government",
        lat: 41.2922589,
        long: 69.2769942,
        reviews: List<Review>()));

    hospitals.add(HospitalModel(
        title: "SHOX INTERNATIONAL HOSPITAL",
        description:
            "Частная многопрофильная клиника, рассчитанная на 20 стационарных больных, а также оказания медицинской помощи 120 амбулаторным больным в день. ",
        phoneNumber: "+998 71 202-02-12",
        address: "Республика Узбекистан,г. Ташкент, 100015 улица Ойбека, 34.",
        category: "private",
        lat: 41.2922589,
        long: 69.2769942,
        imgUrl: "",
        reviews: reviews));
    hospitals.add(HospitalModel(
        title: "'НУРОНИЙ' СТАЦИОНАР",
        description: " ",
        phoneNumber: "+998 71 2915623",
        address:
            "Республика Узбекистан,г. Ташкент,Яшнабадский туп. 1-й ОШСКОЙ, 6А",
        category: "government",
        lat: 41.2922589,
        long: 69.2769942,
        reviews: List<Review>(),
        imgUrl: "http://mku.uz/logo/461.jpg"));
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTab = tabController.index;
    });
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
                        title: hospital.title,
                        description: hospital.description,
                        phonenumber: hospital.phoneNumber,
                        address: hospital.address,
                        lang: hospital.long,
                        lat: hospital.lat,
                        reviews: reviewslist,
                        imgUrl: hospital.imgUrl,
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

  Widget createTabContent(String category) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 20.0),
      itemCount: hospitals.length,
      itemBuilder: (context, index) {
        var hospital = hospitals[index];
        var reviewslist = hospitals[index].reviews;
        if (hospital.category == category) {
          return createHospitalRow(hospital, reviewslist);
        } else if (category == "all") {
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
          child: TabBarView(
        controller: tabController,
        children: <Widget>[
          createTabContent("all"),
          createTabContent("government"),
          createTabContent("private"),
        ],
      )),
    );
  }
}
