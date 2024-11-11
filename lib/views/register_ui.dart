// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, unused_import, unused_local_variable, unrelated_type_equality_checks

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

  File? _imageSelected;
  String? _image64Selected;

  //method เปิดกล้องถ่ายรูป
  Future<void> _openCamera() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected = File(_picker.path);
        _image64Selected = base64Encode(_imageSelected!.readAsBytesSync());
      });
    }
  }

  //method เปิดแกลลอรี่เลือกรูป
  Future<void> _openGallery() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected = File(_picker.path);
        _image64Selected = base64Encode(_imageSelected!.readAsBytesSync());
      });
    }
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

  Future showCompleteDialog(context, msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'ผลการทำงาน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
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
                        _openCamera();
                      },
                      icon: Icon(
                        FontAwesomeIcons.cameraRetro,
                        color: Colors.amber,
                      ),
                    ),
                    _imageSelected == null
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
                              _imageSelected!,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                    IconButton(
                      onPressed: () {
                        _openGallery();
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
                    } else if (phoneCtrl.text.trim().length != 10) {
                      showWarningMessage(
                          context, 'กรุณาป้อนเบอร์โทรศัพท์ให้ถูกต้อง');
                    } else if (usernameCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'กรุณาป้อนชื่อผู้ใช้');
                    } else if (passwordCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'กรุณาป้อนรหัสผ่าน');
                    } else if (_imageSelected == null ||
                        _image64Selected == null) {
                      showWarningMessage(context, 'กรุณาถ่ายรูป/เลือกรูป');
                    } else {
                      Profile profile = Profile(
                        fullname: fullnameCtrl.text.trim(),
                        email: emailCtrl.text.trim(),
                        phone: phoneCtrl.text.trim(),
                        username: usernameCtrl.text.trim(),
                        password: passwordCtrl.text.trim(),
                        upic: _image64Selected,
                      );
                      CallAPI.callRegisterAPI(profile).then((value) {
                        if (value.message == '1') {
                          showCompleteDialog(context, 'ลงทะเบียนสำเร็จ!!')
                              .then((value) {
                            Navigator.pop(context);
                          });
                        } else if (value.message == '2') {
                          showWarningMessage(
                              context, 'ชื่อผู้ใช้นี้มีอยู่ในระบบแล้ว');
                        } else if (value.message == '3') {
                          print(value.message);
                          showWarningMessage(
                              context, 'ชื่อนี้มีอยู่ในระบบแล้ว');
                        } else {
                          showWarningMessage(context,
                              'ลงทะเบียนไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                        }
                      });
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
