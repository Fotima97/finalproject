import 'dart:io';
import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/appointmentImageModel.dart';
import 'package:finalproject/helpers/appointmentModel.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/iosalertBox.dart';
import 'package:finalproject/helpers/specializationDropDown.dart';
import 'package:finalproject/pages/addmedicinepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddAppointment extends StatefulWidget {
  AddAppointment({Key key, this.action, this.appointment, this.images})
      : super(key: key);
  final String action;
  final Appointment appointment;
  final List<Images> images;
  _AddAppointmentState createState() => new _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  TextEditingController _doctorController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  TextEditingController _placeController = new TextEditingController();
  TextEditingController _notificationController = new TextEditingController();
  TextEditingController _notesController = new TextEditingController();
  File image;
  bool _alarm = false;
  List<String> appointmentImages = [];

  String timeText =
      language == eng ? 'Time' : language == rus ? "Время" : "Vaqti";
  String notificationTime = language == eng
      ? 'Notification Time'
      : language == rus ? "Время уведомления" : "Xabarnoma vaqti";
  @override
  void initState() {
    // TODO: implement initState
    if (widget.action == edit) {
      _doctorController.text = widget.appointment.doctorName;
      _dateController.text = widget.appointment.appointmentDate;
      _timeController.text = widget.appointment.appointmentTime;
      _placeController.text = widget.appointment.appointmentPlace;
      _notesController.text = widget.appointment.appointmentNotes;
      _notificationController.text = widget.appointment.alarmTime;
      _alarm = widget.appointment.alarm;
      specialDropDown = widget.appointment.specialization;
    }
    if (widget.images != null) {
      for (int i = 0; i < widget.images.length; i++) {
        appointmentImages.add(widget.images[i].imageSrc);
      }
    }

    super.initState();
  }

  String formDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String formTime(DateTime time) {
    return DateFormat("HH:mm").format(time);
  }

  void _showDeleteButton(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.red,
            child: MaterialButton(
              minWidth: 500.0,
              height: 50.0,
              child: Text(
                language == eng
                    ? "Delete"
                    : language == rus ? "Удалить" : "O'chirish",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              onPressed: () {
                appointmentImages.removeAt(index);
                setState(() {});
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  Widget createTimePicker(
      TextEditingController controller, BuildContext context, String text) {
    return InkWell(
      onTap: () {
        _showTimeKeeper(context, controller);
      },
      child: TextField(
        enabled: false,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.access_time),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.red, width: 3.0)),
          hintText: text,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CupertinoDatePicker(
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _dateController.text = formDate(value);
              });
            },
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            maximumYear: 2100,
            minimumYear: 1900,
          );
        });
  }

  void _showTimeKeeper(BuildContext context, TextEditingController controller) {
    DatePicker.showTimePicker(context,
        showTitleActions: true, currentTime: DateTime.now(), onConfirm: (time) {
      setState(() {
        controller.text = formTime(time);
      });
    });
  }

  Widget notificationTimePicker(bool notification, BuildContext context,
      TextEditingController controller, String text) {
    if (notification) {
      return createTimePicker(controller, context, text);
    } else {
      return Container();
    }
  }

  openGallery() async {
    var fileimage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (fileimage != null) {
      image = fileimage;
      appointmentImages.add(image.path);
    }
    setState(() {});
  }

  openCamera() async {
    var cameraimage = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (cameraimage != null) {
      image = cameraimage;
      appointmentImages.add(image.path);
    }
    setState(() {});
  }

  Widget createDialogBox() {
    return CupertinoAlertDialog(
      title: Text(language == eng
          ? "Add an image"
          : language == rus ? "Добавить изображение" : "Rasm qoshish"),
      content: Column(
        children: <Widget>[
          MaterialButton(
            minWidth: 300.0,
            child: Text(language == eng
                ? "Pick an image"
                : language == rus ? "Выбрать изображение" : "Tasvirni tanlash"),
            onPressed: () {
              openGallery();
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            minWidth: 300.0,
            child: Text(language == eng
                ? "Take a photo"
                : language == rus ? "Сфотографировать" : "Suratga olish"),
            onPressed: () {
              openCamera();
              Navigator.pop(context);
            },
          )
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(language == eng
              ? "Close"
              : language == rus ? "Закрыть" : "Yopish"),
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
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[
            Container(
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: Container(
                        padding: EdgeInsets.all(11.0),
                        child: Image.asset(
                          'assets/doctorIcon.png',
                          height: .2,
                          color: Colors.grey,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 3.0)),
                      hintText: language == eng
                          ? "Doctor"
                          : language == rus ? "Врач" : "Shifokor"),
                  controller: _doctorController,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0))),
            SizedBox(
              height: 15.0,
            ),
            DocSpecialization(action: widget.action),
            SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                _showDatePicker(context);
              },
              child: TextField(
                enabled: false,
                controller: _dateController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.date_range),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.red, width: 3.0)),
                  hintText: language == eng
                      ? 'Date'
                      : language == rus ? "День" : "Kun",
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            createTimePicker(_timeController, context, timeText),
            SizedBox(
              height: 15.0,
            ),
            Container(
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: Container(
                        padding: EdgeInsets.all(11.0),
                        child: Image.asset(
                          'assets/hospitalIcon.png',
                          height: .2,
                          color: Colors.grey,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 3.0)),
                      hintText: language == eng
                          ? "Hospital name / address"
                          : language == rus
                              ? "Название / адрес больницы"
                              : "Kasalxonaning nomi / manzili"),
                  controller: _placeController,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0))),
            SizedBox(
              height: 15.0,
            ),
            Container(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.comment),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 3.0)),
                      hintText: language == eng
                          ? 'Notes'
                          : language == rus ? "Заметки" : "Izohlar"),
                  controller: _notesController,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0))),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    language == eng
                        ? "Reminder"
                        : language == rus ? "Напоминание" : "Eslatma",
                  ),
                ),
                Container(
                  width: 20.0,
                ),
                Container(
                  child: Switch(
                    value: _alarm,
                    onChanged: (bool value) {
                      setState(() {
                        _alarm = value;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            notificationTimePicker(
                _alarm, context, _notificationController, notificationTime),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        language == eng
                            ? "Additional files"
                            : language == rus
                                ? "Дополнительные файлы"
                                : "Qo'shimcha faylar",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                      MaterialButton(
                        minWidth: 90.0,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return createDialogBox();
                              });
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: appointmentImages.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 90.0),
                    itemBuilder: (context, index) {
                      if (appointmentImages.length > 0) {
                        return GestureDetector(
                          child: Card(
                            child: GridTile(
                                child: Image.asset(
                              appointmentImages[index],
                            )),
                          ),
                          onLongPress: () {
                            _showDeleteButton(context, index);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 60.0,
          color: accentColor,
          child: Center(
            child: Text(
              language == eng
                  ? 'Save'
                  : language == rus ? "Сохранить" : "Saqlash",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        onTap: () async {
          if (widget.action == edit) {
            await DBProvider.db.updateAppointment(new Appointment(
                appointmentId: widget.appointment.appointmentId,
                doctorName: _doctorController.text,
                appointmentDate: _dateController.text,
                appointmentTime: _timeController.text,
                appointmentPlace: _placeController.text,
                specialization: specialDropDown,
                appointmentNotes: _notesController.text,
                alarm: _alarm,
                alarmTime: _notificationController.text));
            await DBProvider.db
                .getImagesByappointment(widget.appointment.appointmentId)
                .then((result) async {
              for (int i = 0; i < result.length; i++) {
                await DBProvider.db.deleteImage(result[i].appointmentImageId);
              }
            });
            for (int i = 0; i < appointmentImages.length; i++) {
              await DBProvider.db.addImage(new Images(
                appointmentId: widget.appointment.appointmentId,
                imageSrc: appointmentImages[i],
              ));
            }
          } else {
            await DBProvider.db.addAppointment(new Appointment(
                doctorName: _doctorController.text,
                appointmentDate: _dateController.text,
                appointmentTime: _timeController.text,
                appointmentPlace: _placeController.text,
                specialization: specialDropDown,
                appointmentNotes: _notesController.text,
                alarm: _alarm,
                alarmTime: _notificationController.text));
            for (int i = 0; i < appointmentImages.length; i++) {
              int id = await DBProvider.db.getLastAppointmentId();
              await DBProvider.db.addImage(new Images(
                appointmentId: id,
                imageSrc: appointmentImages[i],
              ));
            }
          }

          Navigator.popUntil(context, (route) {
            return route.settings.name == "/doctors";
          });
        },
      ),
    );
  }
}
