import 'dart:io';
import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/appointmentImageModel.dart';
import 'package:finalproject/helpers/appointmentModel.dart';
import 'package:finalproject/helpers/medicationModel.dart';
import 'package:finalproject/helpers/reminderModel.dart';
import 'package:finalproject/helpers/usermodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String pillsPath = join(documentsDirectory.path, "MedHelper.db");

    return await openDatabase(pillsPath, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      _create(db, version);
    });
  }

  Future _create(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $medicationTable ($medId INTEGER PRIMARY KEY AUTOINCREMENT, $medName TEXT, $shape TEXT, $color INTEGER, $dosedb  INTEGER, $units TEXT, $times INTEGER, $startDate TEXT, $endDate TEXT, $duration INTEGER, $notes TEXT)');
    await db.execute(
        'CREATE TABLE $reminderTable ($reminderId INTEGER PRIMARY KEY AUTOINCREMENT, $medId INTEGER, $notificationTime TEXT, $token BIT,Constraint fk_medId FOREIGN KEY($medId) REFERENCES $medicationTable($medId))');
    await db.execute(
        'CREATE TABLE $appointmentTable ($appointmentId INTEGER PRIMARY KEY AUTOINCREMENT, $doctorName TEXT, $appointmentDate TEXT, $appointmentTime TEXT,$appointmentPlaceField TEXT, $specializationField  TEXT, $appointmentNotesField TEXT, $alarm BIT, $alarmTime TEXT)');
    await db.execute(
        'CREATE TABLE $imagesTable ($appointmentImageId INTEGER PRIMARY KEY AUTOINCREMENT, $appointmentId INTEGER, $imageSrc TEXT,Constraint fk_appointmentId FOREIGN KEY($appointmentId) REFERENCES $appointmentTable($appointmentId))');
    await db.execute(
        'CREATE TABLE $usersTable($fullName TEXT, $birthdatefield TEXT, $emailfield Text, $bloodType Text, $allergies Text)');
  }

  addMedication(Medication newMed) async {
    final db = await database;
    var res = await db.rawInsert(
        'INSERT Into $medicationTable ($medName,$shape,$color,$dosedb, $units, $times, $startDate, $endDate,$duration, $notes) VALUES ("${newMed.medName}", "${newMed.shape}", ${newMed.color},${newMed.dose},"${newMed.units}",${newMed.times},"${newMed.startDate}","${newMed.endDate}",${newMed.duration}, "${newMed.notes}")');
    return res;
  }

  createUser(User user) async {
    final db = await database;
    var res = await db.rawInsert(
        'INSERT Into $usersTable ($fullName,$birthdatefield,$emailfield,$bloodType, $allergies) VALUES ("${user.fullName}", "${user.birthDate}", "${user.email}","${user.bloodType}","${user.allergies}")');
    return res;
  }

  addAppointment(Appointment newAppoinment) async {
    final db = await database;
    int alarmresult = newAppoinment.alarm ? 1 : 0;

    var res = await db.rawInsert(
        'INSERT Into $appointmentTable ($doctorName,$appointmentDate,$appointmentTime,$appointmentPlaceField, $specializationField, $appointmentNotesField, $alarm, $alarmTime) VALUES ("${newAppoinment.doctorName}", "${newAppoinment.appointmentDate}", "${newAppoinment.appointmentTime}","${newAppoinment.appointmentPlace}","${newAppoinment.specialization}","${newAppoinment.appointmentNotes}",$alarmresult,"${newAppoinment.alarmTime}")');
    return res;
  }

  addImage(Images newImage) async {
    final db = await database;
    var res = await db.rawInsert(
        'INSERT Into $imagesTable( $appointmentId, $imageSrc) VALUES (${newImage.appointmentId}, "${newImage.imageSrc}")');

    return res;
  }

  addReminder(Reminder newReminder) async {
    final db = await database;
    int tokeresult = newReminder.token ? 1 : 0;
    var res = await db.rawInsert(
        'INSERT Into $reminderTable($medId, $notificationTime, $token) VALUES (${newReminder.medId}, "${newReminder.notificationTime}", $tokeresult)');

    return res;
  }

  getAppointmentById(int id) async {
    final db = await database;
    var res = await db.query("$appointmentTable",
        where: "$appointmentId = ?", whereArgs: [id]);
    return res.isNotEmpty ? Appointment.fromJson(res.first) : Null;
  }

  getMedicationById(int id) async {
    final db = await database;
    var res = await db
        .query("$medicationTable", where: "$medId = ?", whereArgs: [id]);
    return res.isNotEmpty ? Medication.fromJson(res.first) : Null;
  }

  getUser(String userName) async {
    final db = await database;
    var res = await db
        .query("$usersTable", where: "$fullName = ?", whereArgs: [userName]);
    return res.isNotEmpty ? User.fromJson(res.first) : Null;
  }

  Future<List<Appointment>> getAllAppointments() async {
    final db = await database;
    var res = await db.query("$appointmentTable");
    List<Appointment> list =
        res.isNotEmpty ? res.map((c) => Appointment.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Images>> getImagesByappointment(int id) async {
    final db = await database;
    var res = await db
        .rawQuery("SELECT * FROM $imagesTable WHERE $appointmentId=$id");
    List<Images> list =
        res.isNotEmpty ? res.map((c) => Images.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Reminder>> getRemindersById(int id) async {
    final db = await database;
    var res =
        await db.rawQuery("SELECT * FROM $reminderTable WHERE $medId=$id");
    List<Reminder> list =
        res.isNotEmpty ? res.map((c) => Reminder.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Medication>> getMedicationsByEndDate() async {
    final db = await database;
    var res = await db
        .rawQuery("SELECT * FROM $medicationTable WHERE $endDate>date('now')");
    List<Medication> list =
        res.isNotEmpty ? res.map((c) => Medication.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Reminder>> getnotTokenReminders() async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM $reminderTable INNER JOIN $medicationTable ON($reminderTable.$medId=$medicationTable.$medId) WHERE  $medicationTable.$endDate>date('now') AND $reminderTable.$token=0");
    List<Reminder> list =
        res.isNotEmpty ? res.map((c) => Reminder.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Reminder>> getRemindersforToday() async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM $reminderTable INNER JOIN $medicationTable ON($reminderTable.$medId=$medicationTable.$medId) WHERE  $medicationTable.$endDate>date('now')");
    List<Reminder> list =
        res.isNotEmpty ? res.map((c) => Reminder.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Medication>> getAllMedications() async {
    final db = await database;
    var res = await db.query("$medicationTable");
    List<Medication> list =
        res.isNotEmpty ? res.map((c) => Medication.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Reminder>> getAllReminder() async {
    final db = await database;
    var res = await db.query("$reminderTable");
    List<Reminder> list =
        res.isNotEmpty ? res.map((c) => Reminder.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> getLastAppointmentId() async {
    final db = await database;
    var table = await db.rawQuery(
        "SELECT MAX($appointmentId) as $appointmentId FROM $appointmentTable");
    int id = table.first["$appointmentId"];
    return id;
  }

  Future<int> getLastMedicationId() async {
    final db = await database;
    var table =
        await db.rawQuery("SELECT MAX($medId) as $medId FROM $medicationTable");
    int id = table.first["$medId"];
    return id;
  }

  updateAppointment(Appointment newAppointment) async {
    final db = await database;
    var res = await db.update("$appointmentTable", newAppointment.toJson(),
        where: "$appointmentId = ?", whereArgs: [newAppointment.appointmentId]);
    return res;
  }

  updateImageList(Images newImage) async {
    final db = await database;
    var res = await db.update("$imagesTable", newImage.toJson(),
        where: "$appointmentImageId = ?",
        whereArgs: [newImage.appointmentImageId]);
    return res;
  }

  updateMedication(Medication newMedication) async {
    final db = await database;
    var res = await db.update("$medicationTable", newMedication.toJson(),
        where: "$medId = ?", whereArgs: [newMedication.medId]);
    return res;
  }

  updateReminder(Reminder newReminder) async {
    final db = await database;
    var res = await db.update("$reminderTable", newReminder.toJson(),
        where: "$reminderId = ?", whereArgs: [newReminder.reminderId]);
    return res;
  }

  updateUser(User newUser) async {
    final db = await database;
    var res = await db.update("$medicationTable", newUser.toJson(),
        where: "$fullName = ?", whereArgs: [newUser.fullName]);
    return res;
  }

  reminderToken(Reminder reminder) async {
    final db = await database;
    Reminder token = Reminder(
        reminderId: reminder.reminderId,
        medId: reminder.medId,
        notificationTime: reminder.notificationTime,
        token: true);
    var res = await db.update("$reminderTable", token.toJson(),
        where: "$reminderId = ?", whereArgs: [reminder.reminderId]);
    return res;
  }

  reminderNotToken(Reminder reminder) async {
    final db = await database;
    Reminder token = Reminder(
        reminderId: reminder.reminderId,
        medId: reminder.medId,
        notificationTime: reminder.notificationTime,
        token: false);
    var res = await db.update("$reminderTable", token.toJson(),
        where: "$reminderId = ?", whereArgs: [reminder.reminderId]);
    return res;
  }

  deleteMedication(int id) async {
    final db = await database;
    db.delete("$medicationTable", where: "$medId = ?", whereArgs: [id]);
  }

  deleteAppointment(int id) async {
    final db = await database;
    db.delete("$appointmentTable",
        where: "$appointmentId = ?", whereArgs: [id]);
  }

  deleteImage(int id) async {
    final db = await database;
    db.delete("$imagesTable",
        where: "$appointmentImageId = ?", whereArgs: [id]);
  }

  deleteReminder(int id) async {
    final db = await database;
    db.delete("$reminderTable", where: "$reminderId = ?", whereArgs: [id]);
  }
}
