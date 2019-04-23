import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/dbProvider.dart';
import 'package:finalproject/helpers/medicationModel.dart';
import 'package:finalproject/helpers/reminderModel.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:finalproject/pages/medicationdetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PillsList extends StatefulWidget {
  // PillsList({Key key, this.tabId}) : super(key: key);

  // final tabId;
  @override
  PillsListState createState() => PillsListState();
}

class PillsListState extends State<PillsList> {
  BoxDecoration containerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(5.0, 5.0),
          color: Color(0xffEDEDED),
          blurRadius: 5.0,
        )
      ]);
  String checkStatus(String date) {
    String status;
    DateTime enddate = DateTime.parse(date);
    var diffrenece = enddate.difference(DateTime.now()).inDays;
    if (diffrenece < 0) {
      status = language == eng
          ? "Completed"
          : language == rus ? "Завершен" : "Tugallandi";
    } else {
      status = language == eng
          ? "Not completed"
          : language == rus ? "Не завершен" : "Bajarilmadi";
    }
    return status;
  }

  Future<List<Reminder>> getReminder(int id) async {
    return await DBProvider.db.getRemindersById(id);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: FutureBuilder<List<Medication>>(
      future: DBProvider.db.getAllMedications(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Medication>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Medication med = snapshot.data[index];
                Future<List<Reminder>> reminderList = getReminder(med.medId);
                return Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: containerDecoration,
                    child: ListTile(
                      leading: Image.asset(
                        med.shape,
                        width: 25.0,
                        height: 40.0,
                        color: Color(med.color),
                      ),
                      title: Text(med.medName),
                      subtitle: Text(checkStatus(med.endDate)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicationDetails(
                                      medication: med,
                                      status: checkStatus(med.endDate),
                                      reminder: reminderList,
                                    )));
                      },
                    ));
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
    ));
  }
}
