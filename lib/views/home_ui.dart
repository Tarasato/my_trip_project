// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_trip_project/models/Profile.dart';
import 'package:my_trip_project/models/Trip.dart';
import 'package:my_trip_project/services/call_api.dart';
import 'package:my_trip_project/utils/env.dart';
import 'package:my_trip_project/views/insert_trip_ui.dart';
import 'package:my_trip_project/views/login_ui.dart';
import 'package:my_trip_project/views/up_del_trip_ui.dart';
import 'package:my_trip_project/views/update_profile_ui.dart';

class HomeUI extends StatefulWidget {
  Profile? profile;
  HomeUI({super.key, this.profile});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //ตัวแปรเก็บข้อมูลการกินของที่ได้จาก API
  Future<List<Trip>>? tripData;

  //method เรียกห API ที่ CallAPI
  getAlllTrip(Trip trip) {
    setState(() {
      tripData = CallAPI.callGetAllTripByUserIDAPI(trip);
    });
  }

  @override
  void initState() {
    print(widget.profile!.upic!);
    Trip trip = Trip(
      userId: widget.profile!.userId,
    );
    getAlllTrip(trip);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'บันทึกการเดินทาง',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (Platform.isAndroid) {
                //Navigator.pop(context);
                //SystemNavigator.pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginUI()));
              } else if (Platform.isIOS) {
                //exit(0);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginUI()));
              }
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.045,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: widget.profile!.userId ==
                      '' //ถ้าไม่มีรูปภาพให้ใช้รูปภาพ default ที่เรากำหนดไว้
                  ? Image.network(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      '${Env.hostName}/mt6552410005/picupload/userpics/${widget.profile!.upic}',
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.045,
            ),
            Text(
              'ชื่อ-สกุล: ${widget.profile!.fullname!}',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Text(
              'ชื่อผู้ใช้: ${widget.profile!.username!}',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Text(
              'อีเมล: ${widget.profile!.email!}',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Text(
              'เบอร์โทรศัพท์: ${widget.profile!.phone!}',
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateProfileUI(profile: widget.profile),
                  ),
                ).then((value) {
                  //ตรวจดูว่า value ที่ส่งกลับมาจากหน้า UpdateProfileUI มีค่าเท่ากับ null หรือไม่
                  if (value != null) {
                    //เอาค่าที่ส่งกลับมาหลังจากกดปุ่ม Update Profile มาแสดง
                    setState(() {
                      widget.profile?.upic = value.upic;
                      widget.profile?.email = value.email;
                      widget.profile?.username = value.username;
                      widget.profile?.fullname = value.fullname;
                      widget.profile?.phone = value.phone;
                      widget.profile?.userId = value.userId;
                    });
                  }
                });
              },
              child: Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Trip>>(
                future: tripData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Expanded(
                          //height: MediaQuery.of(context).size.height * 0.1,
                          //width: MediaQuery.of(context).size.width * 0.22,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  } else if (snapshot.data == null) {
                    return Text('ไม่มีข้อมูลการเดินทาง');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpDelTripUI(
                                        trip: snapshot.data![index],
                                      ),
                                    )).then((value) {
                                  if (mounted) {
                                    setState(() {
                                      Trip trip = Trip(
                                        userId: widget.profile!.userId,
                                      );
                                      getAlllTrip(trip);
                                    });
                                  }
                                });
                              },
                              tileColor: index % 2 == 0
                                  ? Colors.red[50]
                                  : Colors.green[50],
                              leading: ClipRRect(
                                child: Image.network(
                                  '${Env.hostName}/mt6552410005/picupload/trippics/${snapshot.data![index].trippic}',
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                snapshot.data![index].locationName!,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.green[800],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.22,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertTripUI(
                userId: widget.profile!.userId!,
              ),
            ),
          ).then((value) {
            setState(() {
              Trip trip = Trip(
                userId: widget.profile!.userId,
              );
              getAlllTrip(trip);
            });
          });
        },
        label: Text(
          'เพิ่มบันทึกการเดินทาง',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.015,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        // child: Column(
        //   children: [
        //     SizedBox(
        //       height: MediaQuery.of(context).size.height * 0.01,
        //     ),
        //     Text(
        //       'เพิ่มการกิน',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: MediaQuery.of(context).size.height * 0.012,
        //       ),
        //     ),
        //     Icon(
        //       Icons.add,
        //       color: Colors.white,
        //     ),
        //   ],
        // ),
        backgroundColor: Colors.amber[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
