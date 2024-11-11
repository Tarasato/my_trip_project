// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_trip_project/models/Profile.dart';
import 'package:my_trip_project/services/call_api.dart';
import 'package:my_trip_project/utils/env.dart';
import 'package:my_trip_project/views/home_ui.dart';
import 'package:my_trip_project/views/login_ui.dart';

class UpdateProfileUI extends StatefulWidget {
  Profile? profile;
  UpdateProfileUI({super.key, this.profile});

  @override
  State<UpdateProfileUI> createState() => _UpdateProfileUIState();
}

class _UpdateProfileUIState extends State<UpdateProfileUI> {
  //ตัวแปรเปิดปิดตา ของช่องรหัสผ่าน
  bool passStatus = true;

  // สร้างตัวแปรควบคุม TextField
  TextEditingController fullnameCtrl = TextEditingController(text: '');
  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');
  TextEditingController phoneCtrl = TextEditingController(text: '');

  showWaringDialog(context, msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'คำเตือน',
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

  // สร้างตัวแปร image ให้เก็บไฟล์ภาพที่ถ่ายจากกล้อง/เลือกจากแกลลอรี่
  File? _imageSelected;

  String? _image64Selected;

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

  @override
  void initState() {
    super.initState();
    fullnameCtrl.text = widget.profile!.fullname!;
    usernameCtrl.text = widget.profile!.username!;
    passwordCtrl.text = widget.profile!.password!;
    emailCtrl.text = widget.profile!.email!;
    phoneCtrl.text = widget.profile!.phone!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'แก้ไขข้อมูลส่วนตัว',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.amber),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: widget.profile!.upic == '' &&
                                    _imageSelected == null
                                ? NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                  )
                                : widget.profile!.upic != null &&
                                        _imageSelected == null
                                    ? NetworkImage(
                                        '${Env.hostName}/mt6552410005/picupload/userpics/${widget.profile!.upic}',
                                      )
                                    : _imageSelected != null
                                        ? FileImage(_imageSelected!)
                                        : NetworkImage(
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                          ),
                            fit: BoxFit.cover,
                          ),
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
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่อ-สกุล :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  controller: fullnameCtrl,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    prefixIcon: Icon(
                      Icons.person_3_rounded,
                    ),
                    hintText: 'ป้อนชื่อ-สกุล',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'อีเมลล์ :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    hintText: 'ป้อนอีเมลล์',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่อผู้ใช้ :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  enabled: false,
                  controller: usernameCtrl,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_add,
                    ),
                    hintText: 'ป้อนชื่อผู้ใช้',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'รหัสผ่าน :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  controller: passwordCtrl,
                  obscureText: passStatus,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passStatus = !passStatus;
                        });
                      },
                      icon: passStatus
                          ? Icon(
                              Icons.visibility_off,
                            )
                          : Icon(
                              Icons.visibility,
                            ),
                    ),
                    hintText: 'ป้อนรหัสผ่าน',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เบอร์โทรศัพท์ :',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  maxLength: 10,
                  controller: phoneCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'ป้อนเบอร์โทรศัพท์',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (fullnameCtrl.text.trim().isEmpty ||
                        emailCtrl.text.trim().isEmpty ||
                        passwordCtrl.text.trim().isEmpty ||
                        phoneCtrl.text.trim().isEmpty) {
                      showWaringDialog(context, 'กรุณาป้อนข้อมูลให้ครบถ้วน');
                    } else if (_image64Selected == '' || _image64Selected == null) {
                      //ไม่ได้แก้ไขภาพ แก้ไขชื่อ
                      //ส่งข้อมูลไปเก็บลงฐานข้อมูล
                      if (fullnameCtrl.text.trim() == widget.profile!.fullname) {//แก้ไขชื่อ
                        Profile profile = Profile(
                          userId: widget.profile!.userId!,
                          fullname: fullnameCtrl.text.trim(),
                          upic: widget.profile!.upic!,
                          //username: widget.profile!.username!,
                          email: emailCtrl.text.trim(),
                          password: passwordCtrl.text.trim(),
                          phone: phoneCtrl.text.trim(),
                        );
                        //เรียกใช้ API
                        CallAPI.callUpdateProfileAPI(profile).then((value) {
                          if (value.message == '1') {
                            showCompleteDialog(
                                    context, 'บันทึกการแก้ไขสำเร็จ!!')
                                .then((value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUI()));
                            });
                          } else if (value.message == '2') {
                            showWaringDialog(
                                context, 'ชื่อนี้ถูกใช้งานอยู่แล้ว');
                          } else {
                            showWaringDialog(context,
                                'บันทึกการแก้ไขไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                          }
                        });
                      } else {
                        Profile profile = Profile(
                          userId: widget.profile!.userId!,
                          fullname: fullnameCtrl.text.trim(),
                          email: emailCtrl.text.trim(),
                          password: passwordCtrl.text.trim(),
                          phone: phoneCtrl.text.trim(),
                        );
                        //เรียกใช้ API
                        CallAPI.callUpdateProfileAPI(profile).then((value) {
                          if (value.message == '1') {
                            showCompleteDialog(
                                    context, 'บันทึกการแก้ไขสำเร็จ!!')
                                .then((value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUI()));
                            });
                          } else if (value.message == '2') {
                            showWaringDialog(
                                context, 'ชื่อนี้ถูกใช้งานอยู่แล้ว');
                          } else {
                            showWaringDialog(context,
                                'บันทึกการแก้ไขไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                          }
                        });
                      }
                    } else if (_imageSelected != null) {
                      if (widget.profile!.fullname !=
                          fullnameCtrl.text.trim()) {
                        Profile profile = Profile(
                          userId: widget.profile!.userId!,
                          fullname: fullnameCtrl.text.trim(),
                          username: widget.profile!.username!,
                          email: emailCtrl.text.trim(),
                          password: passwordCtrl.text.trim(),
                          phone: phoneCtrl.text.trim(),
                          upic: _image64Selected,
                        );
                        //เรียกใช้ API
                        CallAPI.callUpdateProfileAPI(profile).then((value) {
                          if (value.message == '1') {
                            showCompleteDialog(
                                    context, 'บันทึกการแก้ไขสำเร็จ!!')
                                .then((value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUI()));
                            });
                          } else if (value.message == '2') {
                            showWaringDialog(
                                context, 'ชื่อนี้ถูกใช้งานอยู่แล้ว');
                          } else {
                            showWaringDialog(context,
                                'บันทึกการแก้ไขไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                          }
                        });
                      } else {
                        Profile profile = Profile(
                          userId: widget.profile!.userId!,
                          //fullname: widget.profile!.fullname!,
                          email: emailCtrl.text.trim(),
                          password: passwordCtrl.text.trim(),
                          phone: phoneCtrl.text.trim(),
                          upic: _image64Selected,
                        );
                        //เรียกใช้ API
                        CallAPI.callUpdateProfileAPI(profile).then((value) {
                          if (value.message == '1') {
                            showCompleteDialog(
                                    context, 'บันทึกการแก้ไขสำเร็จ!!')
                                .then((value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUI()));
                            });
                          } else if (value.message == '2') {
                            showWaringDialog(
                                context, 'ชื่อนี้ถูกใช้งานอยู่แล้ว');
                          } else {
                            showWaringDialog(context,
                                'บันทึกการแก้ไขไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                          }
                        });
                      }
                    }
                  },
                  child: Text(
                    'บันทึกการแก้ไข',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Profile profile = Profile(
                      userId: widget.profile!.userId!,
                    );
                    CallAPI.callDeleteUserAPI(profile).then((value) {
                      if (value.message == '1') {
                        showCompleteDialog(context, 'ลบบัญชีผู้ใช้สําเร็จ!!')
                            .then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUI()));
                        });
                      } else if (value.message == '2') {
                        showWaringDialog(context, 'เกิดข้อผิดพลาดในการลบบัญชีผู้ใช้');
                      } else {
                        showWaringDialog(context, 'ลบบัญชีผู้ใช้ไม่สําเร็จ กรุณาลองใหม่อีกครั้ง');
                      }
                    });
                  },
                  child: Text(
                    'ลบบัญชีผู้ใช้',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                ),
              ),
            
            ],
          ),
        )),
      ),
    );
  }
}
