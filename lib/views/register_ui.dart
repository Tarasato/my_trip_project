// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, unused_import, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_trip_project/models/Profile.dart';
import 'package:my_trip_project/services/call_api.dart';
import 'package:my_trip_project/views/login_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  bool pwdStatus = true;

  TextEditingController fullnameCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');
  TextEditingController phoneCtrl = TextEditingController(text: '');
  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');

  File? showImage;
  String? userpicture;
  String? userPicture64;

  takePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    //เก็บรูปลงเครื่อง
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String newDirectory = appDirectory.path + Uuid().v4();
    File newImageFile = File(newDirectory);

    //เก็บรูปในตัวแปรที่สร้างไว้ใน DB
    userpicture = newDirectory;

    await newImageFile.writeAsBytes(File(image.path).readAsBytesSync());
    setState(() {
      showImage = newImageFile;
    });
  }

  SelectPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    //เก็บรูปลงเครื่อง
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String newDirectory = appDirectory.path + Uuid().v4();
    File newImageFile = File(newDirectory);

    //เก็บรูปในตัวแปรที่สร้างไว้ใน DB
    userpicture = newDirectory;

    await newImageFile.writeAsBytes(File(image.path).readAsBytesSync());
    setState(() {
      showImage = newImageFile;
    });
  }

  showWarningMessage(context, msg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คำเตือน'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'ลงทะเบียนเข้าใช้งาน',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        takePhoto();
                      },
                      icon: Icon(
                        FontAwesomeIcons.cameraRetro,
                        color: Colors.amber,
                      ),
                    ),
                    showImage == null
                        ? CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.2,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/logo.png',
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              showImage!,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                    IconButton(
                      onPressed: () {
                        SelectPhoto();
                      },
                      icon: Icon(
                        FontAwesomeIcons.photoFilm,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: fullnameCtrl,
                    decoration: InputDecoration(
                      labelText: 'ชื่อ-สกุล',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'อีเมล์',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: phoneCtrl,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'เบอร์โทรศัพท์',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: TextField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    bottom: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: TextField(
                    controller: passwordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'รหัสผ่าน',
                      labelStyle: GoogleFonts.kanit(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            pwdStatus = pwdStatus == true ? false : true;
                          });
                        },
                        icon: Icon(
                          pwdStatus == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    //Validate หน้าจอ
                    if (fullnameCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'กรุณาป้อนชื่อ-สกุล');
                    } else if (emailCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'กรุณาป้อนอีเมลล์');
                    } else if (phoneCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'กรุณาป้อนเบอร์โทรศัพท์');
                    }else if (phoneCtrl.text.trim().length != 10) {
                      showWarningMessage(context, 'กรุณาป้อนเบอร์โทรศัพท์ให้ถูกต้อง');
                    } else if (usernameCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'กรุณาป้อนชื่อผู้ใช้');
                    } else if (passwordCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'กรุณาป้อนรหัสผ่าน');
                    } else if (showImage == null) {
                      showWarningMessage(context, 'กรุณาถ่ายรูป/เลือกรูป');
                    } else {
                      final bytes = await showImage!.readAsBytes();
                      userPicture64 = base64Encode(bytes);
                      //บันทึกลงฐานข้อมูล
                      Profile profile = Profile(
                              username: usernameCtrl.text.trim(),
                              password: passwordCtrl.text.trim(),
                              email: emailCtrl.text.trim(),
                              phone: phoneCtrl.text.trim(),
                              fullname: fullnameCtrl.text.trim(),
                              userpicture: userPicture64,
                            );
                            // CallAPI.callnewProfileAPI(profile).then((value) {
                            //   if (value.message == '1') {
                            //     Navigator.pushReplacement(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => LoginUI()));
                            //   } else {
                            //     showWarningMessage(
                            //         context, 'เกิดข้อผิดพลาด กรุณาติดต่อผู้ดูแลระบบ');
                            //   }
                            // });
                    }
                  },
                  child: Text(
                    'ลงทะเบียน',
                    style: GoogleFonts.kanit(),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.width * 0.125,
                    ),
                    backgroundColor: Colors.amber,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
