// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_trip_project/models/Profile.dart';
import 'package:my_trip_project/services/call_api.dart';
import 'package:my_trip_project/views/home_ui.dart';
import 'package:my_trip_project/views/register_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  bool pwdStatus = true;

  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');

  showWaringDialog(BuildContext context, String msg) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'บันทึกการเดินทาง',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'เข้าใช้งานแอปพลิเคชัน',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                  ),
                ),
                Text(
                  'My Trip',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: MediaQuery.of(context).size.height * 0.045,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                  children: [
                    Text(
                      'ชื่อผู้ใช้: ',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.045,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: usernameCtrl,
                ),
                Row(
                  children: [
                    Text(
                      'รหัสผ่าน: ',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.045,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: passwordCtrl,
                  obscureText: pwdStatus,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pwdStatus = !pwdStatus; // Toggle password visibility
                        });
                      },
                      icon: Icon(
                        pwdStatus ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (usernameCtrl.text.trim().isEmpty && passwordCtrl.text.trim().isEmpty) {
                      showWaringDialog(context, 'กรุณาป้อนชื่อผู้ใช้และรหัสผ่าน');
                    } else if (usernameCtrl.text.trim().isEmpty) {
                      showWaringDialog(context, 'กรุณาป้อนชื่อผู้ใช้');
                    } else if (passwordCtrl.text.trim().isEmpty) {
                      showWaringDialog(context, 'กรุณาป้อนรหัสผ่าน');
                    } else {
                      // ตรวจสอบชื่อผู้ใช้และรหัสผ่านใน DB ผ่าน API
                      Profile profile = Profile(
                        username: usernameCtrl.text.trim(),
                        password: passwordCtrl.text.trim(),
                      );
                      CallAPI.callCheckLoginAPI(profile).then((value) {
                        if (value.message == '1') {
                          // เมื่อเข้าสู่ระบบสำเร็จ
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeUI(), // ส่งข้อมูลผู้ใช้ไปหน้า Home
                            ),
                          );
                        } else {
                          showWaringDialog(context, 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง');
                        }
                      });
                    }
                  },
                  child: Text(
                    'SIGN IN',
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50.0,
                    ),
                    backgroundColor: Colors.amber,
                  ),
                ),
                CheckboxListTile(
                  onChanged: (paramValue) {},
                  value: false,
                  title: Text('จำค่าการเข้าใช้งานแอปฯ'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterUI(),
                      ),
                    );
                  },
                  child: Text('ลงทะเบียนเข้าใช้งาน'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
