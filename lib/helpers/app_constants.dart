import 'dart:ui';

import 'package:flutter/material.dart';

final backgroundColor = Color(0xFFF5F6FE);
final accentColor = Color(0xFFfa5a96);
final greyColor = Color(0xFFc1c3f3);
final primaryColor = Color(0xFF9b63f8);

final blueColor = Color(0xFF94AEFC);
final greenColor = Color(0xFF32CBA5);
final backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomLeft,
    tileMode: TileMode.mirror,
    colors: [
      Colors.blue.shade300.withGreen(5),
      Colors.deepPurple.shade300.withOpacity(1),
    ]);
final languageState = "language";
final eng = "ENG";
final rus = "RUS";
final uzb = "UZB";
final userFullName = 'fullname';
final userBirthDate = 'birthdate';
final userBloodType = 'bloodType';
final userAllergies = "allergies";
final userEmail = "email";
final onlineSaved = "OnlineSaved";
final appName = "Final Project";
final i1 = "i+";
final i2 = "i-";
final o1 = "ii+";
final o2 = "ii-";
final b1 = "iii+";
final b2 = "iii-";
final c1 = "iv+";
final c2 = "iv-";
final switchValue = "SwitchValue";
final loginState = "logged in";
final photos = "photos";
final edit = "Edit";

//database
final medicationTable = "Medications";
final reminderTable = "Reminders";
final appointmentTable = "Appointments";
final imagesTable = "Images";
final usersTable = "Users";
final medId = "MedId";
final medName = "MedName";
final shape = "Shape";
final color = "Color";
final dosedb = "Dose";
final units = "Units";
final times = "Times";
final startDate = "StartDate";
final endDate = "EndDate";
final duration = "Duration";
final reminderId = "ReminderId";
final notificationTime = "NotificationTime";
final token = "Token";
final notes = "Notes";
final appointmentId = "AppointmentId";
final doctorName = "DoctorName";
final appointmentDate = "AppointmentDate";
final appointmentTime = "AppointmentTime";
final specializationField = "Specialization";
final appointmentPlaceField = "AppointmentPlace";
final appointmentNotesField = "Notes";
final alarm = "Alarm";
final alarmTime = "AlarmTime";
final appointmentImageId = "AppointmentImageId";
final imageSrc = "ImageSrc";
final fullName = "FullName";
final birthdatefield = "BirthDate";
final emailfield = "Email";
final bloodType = "BloodType";
final allergies = "Allergies";

//Pills shapes
final circlepillShape = "assets/circlepill.png";
final pillShape = "assets/pill2.png";
final heartShape = 'assets/heart.png';
final bottleShape = "assets/bottle.png";
final infusionShape = "assets/infusion.png";
final lotionShape = "assets/lotion.png";
final triangleShape = "assets/triangle.png";
final starShape = "assets/star.png";
final streamlineShape = "assets/streamline.png";
final pasteShape = "assets/paste.png";

//Pills colors
final blueAccent = Colors.blueAccent;
final red = Colors.red;
final orange = Colors.orange;
final purpleAccent = Colors.purpleAccent;
final cyan = Colors.cyan;
final green = Colors.green;
final brown = Colors.brown;
final indigo = Colors.indigo;
final teal = Colors.teal;
final amber = Colors.amber;
final lime = Colors.lime;
