// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_field, must_be_immutable, unused_import, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_trip_project/models/Trip.dart';
import 'package:my_trip_project/services/call_api.dart';

class InsertTripUI extends StatefulWidget {
  String? userId;
  InsertTripUI({super.key, this.userId});

  @override
  State<InsertTripUI> createState() => _InsertTripUIState();
}

class _InsertTripUIState extends State<InsertTripUI> {
  //ตัวแปรสําหรับเก็บค่าที่กรอกในฟอร์ม
  TextEditingController locationnameCtrl = TextEditingController(text: '');
  TextEditingController tripPayCtrl = TextEditingController(text: '');
  TextEditingController tripDayCtrl = TextEditingController(text: '');
  TextEditingController tripStartCtrl = TextEditingController(text: '');
  TextEditingController tripEndCtrl = TextEditingController(text: '');
  TextEditingController tripDaysCtrl = TextEditingController(text: '');
  // สร้างตัวแปร image ให้เก็บไฟล์ภาพที่ถ่ายจากกล้อง/เลือกจากแกลลอรี่
  File? _imageSelected, _imageSelected2, _imageSelected3;


  String? _image64Selected,
      _image64Selected2,
      _image64Selected3,
      _tripDateStartSelected,
      _tripDateEndSelected,
      _tripLat,
      _tripLng;

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

  //method เปิดกล้องถ่ายรูป
  Future<void> _openCamera2() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected2 = File(_picker.path);
        _image64Selected2 = base64Encode(_imageSelected2!.readAsBytesSync());
      });
    }
  }

  //method เปิดแกลลอรี่เลือกรูป
  Future<void> _openGallery2() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected2 = File(_picker.path);
        _image64Selected2 = base64Encode(_imageSelected2!.readAsBytesSync());
      });
    }
  }

  //method เปิดกล้องถ่ายรูป
  Future<void> _openCamera3() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected3 = File(_picker.path);
        _image64Selected3 = base64Encode(_imageSelected3!.readAsBytesSync());
      });
    }
  }

  //method เปิดแกลลอรี่เลือกรูป
  Future<void> _openGallery3() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected3 = File(_picker.path);
        _image64Selected3 = base64Encode(_imageSelected3!.readAsBytesSync());
      });
    }
  }

  //เปิดปฏิทินเลือกวันที่
  Future<void> _showCalendar(_tripDateSelected, tripDateCtrl) async {
    final DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1),
      lastDate: DateTime(2100),
    );
    //นำค่าวันที่ที่เลือกมาแสดงใน TextField
    if (_picker != null) {
      setState(() {
        _tripDateSelected = _picker.toString().substring(0, 10); //2024-01-31
        tripDateCtrl.text = convertToThaiDate(_picker); //31 มกราคม 2567
      });
    }
  }

  //เมธอดแปลงวันที่แบบสากล (ปี ค.ศ.-เดือน ตัวเลข-วัน ตัวเลข) ให้เป็นวันที่แบบไทย (วัน เดือน ปี)
  //                             2023-11-25
  convertToThaiDate(date) {
    String day = date.toString().substring(8, 10);
    String year = (int.parse(date.toString().substring(0, 4)) + 543).toString();
    String month = '';
    int monthTemp = int.parse(date.toString().substring(5, 7));
    switch (monthTemp) {
      case 1:
        month = 'มกราคม';
        break;
      case 2:
        month = 'กุมภาพันธ์';
        break;
      case 3:
        month = 'มีนาคม';
        break;
      case 4:
        month = 'เมษายน';
        break;
      case 5:
        month = 'พฤษภาคม';
        break;
      case 6:
        month = 'มิถุนายน';
        break;
      case 7:
        month = 'กรกฎาคม';
        break;
      case 8:
        month = 'สิงหาคม';
        break;
      case 9:
        month = 'กันยายน';
        break;
      case 10:
        month = 'ตุลาคม';
        break;
      case 11:
        month = 'พฤศจิกายน';
        break;
      default:
        month = 'ธันวาคม';
    }

    return int.parse(day).toString() + ' ' + month + ' ' + year;
  }

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

  Position? currentPosition;
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      currentPosition = position;
      _tripLat = position.latitude.toString();
      _tripLng = position.longitude.toString();
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'เพิ่มบันทึกการเดินทาง',
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
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
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
                        : Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  _imageSelected!,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    _imageSelected != null
                        ? Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _openCamera2();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.cameraRetro,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  _imageSelected2 == null
                                      ? CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/logo.png',
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.file(
                                            _imageSelected2!,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _openGallery2();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.photoFilm,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _imageSelected2 = null;
                                        _image64Selected2 = null;
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.trash,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                  ],
                ),
                Column(
                  children: [
                    _imageSelected2 != null
                        ? Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _openCamera3();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.cameraRetro,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  _imageSelected3 == null
                                      ? CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/logo.png',
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.file(
                                            _imageSelected3!,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _openGallery3();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.photoFilm,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _imageSelected3 = null;
                                        _image64Selected3 = null;
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.trash,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'สถานที่',
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
                    controller: locationnameCtrl,
                    decoration: InputDecoration(
                      hintText: 'ป้อนชื่อสถานที่',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
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
                      'ค่าใช้จ่าย',
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
                    keyboardType: TextInputType.number,
                    controller: tripPayCtrl,
                    decoration: InputDecoration(
                      hintText: 'ป้อนค่าใช้จ่าย',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
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
                      'วันที่ไป',
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
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: tripStartCtrl,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'เลือกวันที่',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showCalendar(_tripDateStartSelected, tripStartCtrl);
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.amber,
                        ),
                      ),
                    ],
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
                      'วันที่กลับ',
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
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: tripEndCtrl,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'เลือกวันที่',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showCalendar(_tripDateEndSelected, tripEndCtrl);
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.amber,
                        ),
                      ),
                    ],
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
                      'จำนวนวันที่เดินทาง',
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
                    keyboardType: TextInputType.number,
                    controller: tripDaysCtrl,
                    decoration: InputDecoration(
                      hintText: 'ป้อนจำนวนวันที่เดินทาง',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_image64Selected == null || _image64Selected == '') {
                      showWaringDialog(context, 'กรุณาเลือกรูปภาพอย่างน้อย 1 รูป');
                    } else if (locationnameCtrl.text.trim() == '') {
                      showWaringDialog(context, 'กรุณากรอกชื่อสถานที่');
                    } else if (tripPayCtrl.text.trim() == '') {
                      showWaringDialog(context, 'กรุณากรอกค่าใช้จ่าย');
                    } else if (tripStartCtrl.text == null) {
                      showWaringDialog(context, 'กรุณาเลือกวันที่ไป');
                    } else if (tripEndCtrl.text == null) {
                      showWaringDialog(context, 'กรุณาเลือกวันที่กลับ');
                    } else {
                      //ส่งข้อมูลไปบันทึกลงฐานข้อมูล
                      //แพ็คข้อมูลที่จะส่ง
                      Trip trip = Trip(
                        trippic: _image64Selected,
                        trippic2: _image64Selected2,
                        trippic3: _image64Selected3,
                        locationName: locationnameCtrl.text.trim(),
                        cost: tripPayCtrl.text.trim(),
                        startDate: tripStartCtrl.text.trim(),
                        endDate: tripEndCtrl.text.trim(),
                        day_Travel: tripDaysCtrl.text.trim(),
                        latitude: _tripLat,
                        longitude: _tripLng,
                        userId: widget.userId,
                      );
                      //ส่งข้อมูลที่แพ็คไปให้ API เพื่อบันทึกการกินลงฐานข้อมูล
                      CallAPI.callInsertTripAPI(trip).then((value) {
                        if (value.message == '1') {
                          showCompleteDialog(context, 'บันทึกการเดินทางสำเร็จ!')
                              .then((value) {
                            Navigator.pop(context);
                          });
                        } else {
                          showWaringDialog(context,
                              'บันทึกการกินไม่สำเร็จ! กรุณาลองใหม่อีกครั้ง');
                        }
                      });
                    }
                  },
                  child: Text(
                    'บันทึกการเดินทาง',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      //ล้างข้อมูลในฟอร์ม
                      _imageSelected = null;
                      _image64Selected = '';
                      _imageSelected2 = null;
                      _image64Selected2 = '';
                      _imageSelected3 = null;
                      _image64Selected3 = '';
                      locationnameCtrl.text = '';
                      tripPayCtrl.text = '';
                      tripStartCtrl.text = '';
                      tripEndCtrl.text = '';
                      tripDaysCtrl.text = '';
                    });
                  },
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
