//call_api.dart
//ไฟล์นี้จะประกอบด้วย method สําหรับเรียก api
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_trip_project/models/Profile.dart';
import 'package:my_trip_project/utils/env.dart';

class CallAPI {
  //method เรียก API ตรวจชื่อผู้ใช้รหัสผ่าน

  static Future<Profile> callCheckLoginAPI(Profile profile) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mt6552410005/apis/checkUserPass.php'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(profile.toJson()),
    );
    if (responseData.statusCode == 200) {
      return Profile.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //method เรียก API บันทึกข้อมูลสมาชิกใหม่
  static Future<Profile> callRegisterAPI(Profile profile) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/mt6552410005/apis/newProfile.php'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(profile.toJson()),
    );
    if (responseData.statusCode == 200) {
      return Profile.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }
}