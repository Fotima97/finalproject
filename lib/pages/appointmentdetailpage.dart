import 'dart:io';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/appointmentImageModel.dart';
import 'package:finalproject/helpers/appointmentModel.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/iosalertBox.dart';
import 'package:finalproject/helpers/medicationModel.dart';
import 'package:finalproject/helpers/reminderModel.dart';
import 'package:finalproject/pages/addappointment.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetail extends StatefulWidget {
  AppointmentDetail({Key key, this.appointment, this.images}) : super(key: key);

  final Appointment appointment;
  final Future<List<Images>> images;

  @override
  AppointmentDetailState createState() => AppointmentDetailState();
}

class AppointmentDetailState extends State<AppointmentDetail> {
  List<Images> images = new List<Images>();

  deleteAppointment(BuildContext context) async {
    await DBProvider.db.deleteAppointment(widget.appointment.appointmentId);
    Navigator.popUntil(context, (route) {
      return route.settings.name == "/doctors";
    });
  }

  List<PhotoViewGalleryPageOptions> createPhotoGallery(List<Images> list) {
    List<PhotoViewGalleryPageOptions> imageList = [];
    PhotoViewGalleryPageOptions galleryOption;
    for (int i = 0; i < list.length; i++) {
      galleryOption = PhotoViewGalleryPageOptions(
        imageProvider: AssetImage(list[i].imageSrc),
      );
      imageList.add(galleryOption);
    }
    return imageList;
  }

  Widget createCupertinoDialogBox(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(language == eng
          ? "Delete"
          : language == rus ? "Удалить" : "O'chirish"),
      content: Text(language == eng
          ? "Are you sure to delete this?"
          : language == rus
              ? "Вы уверены, что хотите удалить это?"
              : "Ushbu ma'lumotlarni o'chirib tashlashga aminmisiz?"),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(
            language == eng
                ? "Cancel"
                : language == rus ? 'Отмена' : 'Bekor qilish',
          ),
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        ),
        CupertinoDialogAction(
          child: Text(language == eng ? "Yes" : language == rus ? "Да" : "Ha"
              //  style: TextStyle(color: primaryColor),
              ),
          onPressed: () {
            deleteAppointment(context);
          },
        )
      ],
    );
  }

  Widget createAndroidAlertBox(BuildContext context) {
    return AlertDialog(
      title: Text(language == eng
          ? "Delete"
          : language == rus ? "Удалить" : "O'chirish"),
      content: Text(language == eng
          ? "Are you sure to delete this?"
          : language == rus
              ? "Вы уверены, что хотите удалить это?"
              : "Ushbu ma'lumotlarni o'chirib tashlashga aminmisiz?"),
      actions: <Widget>[
        FlatButton(
          child: Text(
            language == eng
                ? "Cancel"
                : language == rus ? 'Отмена' : 'Bekor qilish',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(language == eng ? "Yes" : language == rus ? "Да" : "Ha"),
          onPressed: () {
            deleteAppointment(context);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language == eng
            ? "Doctor's appointment"
            : language == rus ? "Прием к врачу" : "Shifokor ko'rigi"),
      ),
      body: Container(
        color: backgroundColor,
        height: 600.0,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: ListView(
              //  mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          language == eng
                              ? "Doctor"
                              : language == rus ? "Врач" : "Shifokor",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.appointment.doctorName,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                            language == eng
                                ? "Specialization"
                                : language == rus
                                    ? "Cпециализация"
                                    : "Mutaxassislik",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.appointment.specialization,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                            language == eng
                                ? 'Date'
                                : language == rus ? "День" : "Kun",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.appointment.appointmentDate,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                            language == eng
                                ? 'Time'
                                : language == rus ? "Время" : "Vaqti",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.appointment.appointmentTime,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                            language == eng
                                ? "Hospital name / address"
                                : language == rus
                                    ? "Название / адрес больницы"
                                    : "Kasalxonaning nomi / manzili",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.appointment.appointmentPlace == ""
                              ? "-"
                              : widget.appointment.appointmentPlace,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                            language == eng
                                ? 'Notes'
                                : language == rus ? "Заметки" : "Izohlar",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.appointment.appointmentNotes == ""
                              ? "-"
                              : widget.appointment.appointmentNotes,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                            language == eng
                                ? "Reminder"
                                : language == rus ? "Напоминание" : "Eslatma",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.appointment.alarmTime == ""
                              ? "-"
                              : widget.appointment.alarmTime,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                FutureBuilder(
                  future: widget.images,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        images = snapshot.data;
                        return Container(
                            width: 100.0,
                            height: 200.0,
                            child: PhotoViewGallery(
                              pageOptions: createPhotoGallery(images),
                              backgroundDecoration:
                                  BoxDecoration(color: Colors.white),
                            ));
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 60.0,
          color: accentColor,
          child: Center(
            child: Text(
              language == eng
                  ? 'Delete'
                  : language == rus ? "Удалить" : "O'chirish",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        onTap: () async {
          if (Platform.isAndroid) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return createAndroidAlertBox(context);
                });
          } else {
            showDialog(
                context: context, child: createCupertinoDialogBox(context));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddAppointment(
                        action: edit,
                        appointment: widget.appointment,
                        images: images,
                      )));
        },
      ),
    );
  }
}
