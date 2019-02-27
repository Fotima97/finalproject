import 'dart:io';

import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialoBox extends StatelessWidget {
  Widget createCupertinoDialogBox(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(language == eng
          ? "Delete"
          : language == rus ? "Удалить" : "O'chirish"),
      content: Text(language == eng
          ? "Are you sure to delete this medication?"
          : language == rus
              ? "Вы уверены, что хотите удалить это лекарство?"
              : "Ushbu dorini o'chirib tashlashga aminmisiz?"),
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
          onPressed: () {},
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
          ? "Are you sure to delete this medication?"
          : language == rus
              ? "Вы уверены, что хотите удалить это лекарство?"
              : "Ushbu dorini o'chirib tashlashga aminmisiz?"),
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
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (Platform.isAndroid) {
      return createAndroidAlertBox(context);
    } else {
      return createCupertinoDialogBox(context);
    }
  }
}
