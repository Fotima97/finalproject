import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/appointmentImageModel.dart';
import 'package:finalproject/helpers/appointmentModel.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/pages/addappointment.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/appointmentdetailpage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/material.dart';

class DoctorsPage extends StatefulWidget {
  _DoctorsPageState createState() => new _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  Future<List<Images>> getImages(int id) async {
    return await DBProvider.db.getImagesByappointment(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Doctor's appointments"
            : language == rus ? "Поход к врачам" : "Shifokor ko'riklari"),
      ),
      body: SafeArea(
          child: Container(
              child: FutureBuilder<List<Appointment>>(
        future: DBProvider.db.getAllAppointments(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Appointment>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Appointment appointment = snapshot.data[index];
                  Future<List<Images>> imageList =
                      getImages(appointment.appointmentId);
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            offset: Offset(5.0, 5.0),
                            color: Color(0xffEDEDED),
                            blurRadius: 5.0,
                          )
                        ]),
                    child: ListTile(
                      title: Text(appointment.doctorName),
                      subtitle: Text(appointment.specialization),
                      trailing: Text(appointment.appointmentDate),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppointmentDetail(
                                      appointment: appointment,
                                      images: imageList,
                                    )));
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                  child: Text(
                language == eng
                    ? "No data"
                    : language == rus ? "Нет данных" : "Ma'lumotlar yoq",
                style: TextStyle(color: Colors.grey),
              ));
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: primaryColor,
            ));
          }
        },
      ))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: accentColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAppointment()));
        },
      ),
    );
  }
}
