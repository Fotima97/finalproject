import 'dart:io';
import 'package:finalproject/helpers/app_constants.dart';
import 'package:finalproject/helpers/usermodel.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/languagepage.dart';
import 'package:finalproject/pages/profileeditpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String convertedbloodtype = " ";
  // File image;

  @override
  void initState() {
    _convertbloodtype();

    super.initState();
  }

  saveProfileImage(String imagelink) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(profile, imagelink);
  }

  openCamera() async {
    var cameraimage = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (cameraimage != null) {
      // image = cameraimage;
      profileImage = cameraimage.path;
    }
    setState(() {});
  }

  @override
  dispose() {
    saveProfileImage(profileImage);
    super.dispose();
  }

  openGallery() async {
    var fileimage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (fileimage != null) {
      profileImage = fileimage.path;
    }
    setState(() {});
  }

  Widget createDialogbox() {
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

  _convertbloodtype() {
    String bloodtype = userData.bloodType;
    if (bloodtype != '-') {
      if (bloodtype == i1) {
        convertedbloodtype = language == eng
            ? "I-positive"
            : language == rus ? "I-положительное" : "I-ijobiy";
      } else if (bloodtype == i2) {
        convertedbloodtype = language == eng
            ? "I-negative"
            : language == rus ? "I-отрицательное" : "I-salbiy";
      } else if (bloodtype == o1) {
        convertedbloodtype = language == eng
            ? "II-positive"
            : language == rus ? "II-положительное" : "II-ijobiy";
      } else if (bloodtype == o2) {
        convertedbloodtype = language == eng
            ? "II-negative"
            : language == rus ? "II-отрицательное" : "II-salbiy";
      } else if (bloodtype == b1) {
        convertedbloodtype = language == eng
            ? "III-positive"
            : language == rus ? "III-положительное" : "III-ijobiy";
      } else if (bloodtype == b2) {
        convertedbloodtype = language == eng
            ? "III-negative"
            : language == rus ? "III-отрицательное" : "III-salbiy";
      } else if (bloodtype == c1) {
        convertedbloodtype = language == eng
            ? "IV-positive"
            : language == rus ? "IV-положительное" : "IV-ijobiy";
      } else if (bloodtype == c2) {
        convertedbloodtype = language == eng
            ? "IV-negative"
            : language == rus ? "IV-отрицательное" : "IV-salbiy";
      } else {
        convertedbloodtype = language == eng
            ? "I-positive"
            : language == rus ? "I-положительное" : "I-ijobiy";
      }
    }
  }

  void _showDeleteButton(BuildContext context) {
    if (profileImage != "") {
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
                  profileImage = "";
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            );
          });
    }
  }

  Widget createDetails(IconData icon, String text) {
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        width: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.topRight,
                child: Icon(
                  icon,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            SizedBox(
              width: 25.0,
            ),
            Expanded(
                flex: 3,
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.0, color: Colors.grey, fontFamily: "Roboto"),
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    _convertbloodtype();

    return Scaffold(
      // appBar: AppBar(
      //     title: Text(language == eng
      //         ? "Profile"
      //         : language == rus ? "Профиль" : "Profil")),
      floatingActionButton: FloatingActionButton(
        tooltip: language == eng
            ? "Edit"
            : language == rus ? "Редактировать" : "Tuzatishlar kiritish",
        child: Icon(Icons.edit),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileEditPage(
                        user: userData,
                      )));
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter:
                            ColorFilter.mode(Colors.black45, BlendMode.darken),
                        image: AssetImage('assets/wallpaper.jpg'),
                        fit: BoxFit.cover),
                    gradient: backgroundGradient,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(8.0, 5.0),
                        color: Colors.grey,
                        blurRadius: 5.0,
                      )
                    ]),
                child: Stack(
                  overflow: Overflow.visible,
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    Positioned(
                      left: 15.0,
                      top: 15.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: -55,
                      left: 100.0,
                      right: 100.0,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onLongPress: () {
                          _showDeleteButton(context);
                        },
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return createDialogbox();
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 3.0, color: Colors.white)),
                          child: CircleAvatar(
                            child: ClipOval(
                                child: Image.asset(
                              profileImage != ""
                                  ? profileImage
                                  : "assets/profile.png",
                              fit: BoxFit.cover,
                              width: 120.0,
                              height: 120.0,
                            )),
                            minRadius: 60.0,
                            maxRadius: 60.0,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        userData.fullName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    createDetails(Icons.today, userData.birthDate),
                    createDetails(Icons.email, userData.email),
                    createDetails(Icons.invert_colors, convertedbloodtype),
                    createDetails(Icons.not_interested, userData.allergies)
                  ],
                ),
              ),
            )
          ],
        ),
        //     child: ListView(
        //   primary: true,
        //   padding: EdgeInsets.all(15.0),
        //   children: <Widget>[
        //     ListTile(
        //       trailing: Icon(Icons.person),
        //       title: Text(
        //         language == eng
        //             ? "Full name"
        //             : language == rus ? "Полное имя" : "To'liq ismi",
        //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        //       ),
        //       subtitle: Text(userData.fullName),
        //     ),
        //     Divider(),
        //     ListTile(
        //       trailing: Icon(Icons.calendar_today),
        //       title: Text(
        //         language == eng
        //             ? "Birth date"
        //             : language == rus ? "День рождение" : "Tug'ilgan kun",
        //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        //       ),
        //       subtitle: Text(userData.birthDate),
        //     ),
        //     Divider(),
        //     ListTile(
        //       trailing: Icon(Icons.mail),
        //       title: Text(
        //         language == eng
        //             ? 'Email'
        //             : language == rus ? "Эл.адрес" : "Elektron pochta",
        //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        //       ),
        //       subtitle: Text(userData.email),
        //     ),
        //     Divider(),
        //     ListTile(
        //       trailing: Image.asset(
        //         'assets/bloodpng.png',
        //         height: 28.0,
        //         color: Colors.grey,
        //       ),
        //       //  SvgPicture.asset(
        //       //   'assets/blood.svg',
        //       //   height: 28.0,
        //       //   color: Colors.grey,
        //       // ),
        //       title: Text(
        //         language == eng
        //             ? "Blood type"
        //             : language == rus ? "Группа крови" : "Qon guruhi",
        //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        //       ),
        //       subtitle: Text(convertedbloodtype),
        //     ),
        //     Divider(),
        //     ListTile(
        //       trailing: Icon(Icons.not_interested),
        //       title: Text(
        //         language == eng
        //             ? "Allergies"
        //             : language == rus ? "Аллергии" : "Allergiyalar",
        //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        //       ),
        //       subtitle: Text(
        //         userData.allergies,
        //         softWrap: true,
        //         overflow: TextOverflow.clip,
        //       ),
        //     ),
        //     Divider(),
        //     SizedBox(
        //       height: 15.0,
        //     ),
        //     Container(
        //       padding: EdgeInsets.symmetric(horizontal: 8.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Row(
        //             children: <Widget>[
        //               Text(
        //                 language == eng
        //                     ? "Additional files"
        //                     : language == rus
        //                         ? "Дополнительные файлы"
        //                         : "Qo'shimcha faylar",
        //                 style: TextStyle(fontSize: 16.0),
        //                 textAlign: TextAlign.left,
        //               ),
        //               MaterialButton(
        //                 minWidth: 90.0,
        //                 onPressed: () {
        //                   showDialog(
        //                       context: context,
        //                       builder: (BuildContext context) {
        //                         return createDialogbox();
        //                       });
        //                 },
        //                 child: Icon(
        //                   Icons.add_a_photo,
        //                   size: 30.0,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 20.0,
        //           ),
        //           GridView.builder(
        //             shrinkWrap: true,
        //             itemCount: savedImages.length,
        //             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //                 maxCrossAxisExtent: 90.0),
        //             itemBuilder: (context, index) {
        //               if (savedImages.length > 0) {
        //                 return GestureDetector(
        //                   child: Card(
        //                     child: GridTile(
        //                         child: Image.asset(
        //                       savedImages[index],
        //                     )),
        //                   ),
        //                   onLongPress: () {
        //                     _showDeleteButton(context, index);
        //                   },
        //                 );
        //               } else {
        //                 return Container();
        //               }
        //             },
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // )
      ),
    );
  }
}
