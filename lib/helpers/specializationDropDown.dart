import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String specialDropDown;

class DocSpecialization extends StatefulWidget {
  DocSpecialization({Key key, this.action}) : super(key: key);
  final String action;
  DocSpecializationState createState() => DocSpecializationState();
}

class DocSpecializationState extends State<DocSpecialization> {
  List<DropdownMenuItem<String>> _dropdDownMenuItems;
  TextStyle fontstyle = TextStyle(color: Colors.grey);
  String obstetrian =
      language == eng ? "Obstetrician" : language == rus ? "Акушер" : "Akusher";
  String allergist = language == eng
      ? "Allergist"
      : language == rus ? "Аллерголог" : "Allergolok";
  String anasteziolog = language == eng
      ? "Anesthetist"
      : language == rus ? "Анестезиолог" : "Anesteziolog";
  String venerolog = language == eng
      ? "Venereologist"
      : language == rus ? "Венеролог" : "Venerolog";
  String gastroenterolog = language == eng
      ? "Gastroenterologist"
      : language == rus ? "Гастроэнтеролог" : "Gastroenterolog";
  String gynecolog = language == eng
      ? "Gynecologist"
      : language == rus ? "Гинеколог" : "Ginekolog";
  String cardiologist = language == eng
      ? "Cardiologist"
      : language == rus ? "Кардиолог" : "Kardiolog";
  String cosmetologist = language == eng
      ? "Cosmetologist"
      : language == rus ? "Косметолог" : "Kosmetolog";
  String masseur =
      language == eng ? "Masseur" : language == rus ? "Масcажист" : "Massaj";
  String neurologist = language == eng
      ? "Neurologist"
      : language == rus ? "Невропатолог" : "Nevropatolog";
  String pediatrician = language == eng
      ? "Pediatrician"
      : language == rus ? "Педиатр" : "Pediatr";
  String therapist =
      language == eng ? "Therapist" : language == rus ? "Терапевт" : "Terapevt";
  String dentist = language == eng
      ? "Dentist"
      : language == rus ? "Стоматолог" : "Stomatolog";
  String ultrasound =
      language == eng ? "Ultrasound" : language == rus ? "УЗИ" : "Uzi";
  String other =
      language == eng ? "Other" : language == rus ? "Другое" : "boshqa";
  @override
  void initState() {
    // TODO: implement initState
    _dropdDownMenuItems = _getmenuitems();
    if (widget.action != edit) {
      specialDropDown = _dropdDownMenuItems[0].value;
    }
    super.initState();
  }

  List<DropdownMenuItem<String>> _getmenuitems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(DropdownMenuItem(
      child: Text(
        obstetrian,
        style: fontstyle,
      ),
      value: obstetrian,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        allergist,
        style: fontstyle,
      ),
      value: allergist,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        anasteziolog,
        style: fontstyle,
      ),
      value: anasteziolog,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        venerolog,
        style: fontstyle,
      ),
      value: venerolog,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        gastroenterolog,
        style: fontstyle,
      ),
      value: gastroenterolog,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        gynecolog,
        style: fontstyle,
      ),
      value: gynecolog,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        cardiologist,
        style: fontstyle,
      ),
      value: cardiologist,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        cosmetologist,
        style: fontstyle,
      ),
      value: cosmetologist,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        masseur,
        style: fontstyle,
      ),
      value: masseur,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        neurologist,
        style: fontstyle,
      ),
      value: neurologist,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        pediatrician,
        style: fontstyle,
      ),
      value: pediatrician,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        dentist,
        style: fontstyle,
      ),
      value: dentist,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        ultrasound,
        style: fontstyle,
      ),
      value: ultrasound,
    ));
    items.add(DropdownMenuItem(
      child: Text(
        other,
        style: fontstyle,
      ),
      value: other,
    ));

    return items;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8.0),
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
      child: FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              border: InputBorder.none,
              //   filled: true,
              fillColor: Colors.white,
              suffixIcon: Container(
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(11.0),
                child: Image.asset(
                  'assets/specializationIcon.png',
                  height: .2,
                  color: Colors.grey,
                ),
              ),
            ),
            isEmpty: specialDropDown == "",
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: _dropdDownMenuItems,
                value: specialDropDown,
                onChanged: (String v) {
                  setState(() {
                    specialDropDown = v;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
