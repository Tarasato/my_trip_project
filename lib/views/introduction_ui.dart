// ignore_for_file: prefer_const_constructors, camel_case_types, unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_trip_project/views/home_ui.dart';
import 'package:my_trip_project/views/login_ui.dart';

class IntroductionUI extends StatefulWidget {
  const IntroductionUI({super.key});

  @override
  State<IntroductionUI> createState() => _IntroductionUIState();
}

class _IntroductionUIState extends State<IntroductionUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber[100],
      body: IntroductionScreen(
        autoScrollDuration: 10000,
        infiniteAutoScroll: true,
        scrollPhysics: BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            titleWidget: Text(
              'อุทยานแห่งชาติหมู่เกาะอ่างทอง',
              style: GoogleFonts.kanit(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            image: Image.asset('assets/images/introductionUI/sni4.jpg'),
            bodyWidget: Text(
              'เมืองร้อยเกาะ',
              style: GoogleFonts.kanit(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'อุทยานแห่งชาติเขาสก',
              style: GoogleFonts.kanit(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            image: Image.asset('assets/images/introductionUI/sni3.jpg'),
            bodyWidget: Text(
              'เงาะอร่อย',
              style: GoogleFonts.kanit(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'เขื่อนเชี่ยวหลาน',
              style: GoogleFonts.kanit(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            image: Image.asset('assets/images/introductionUI/sni2.jpg'),
            bodyWidget: Text(
              'หอยใหญ่',
              style: GoogleFonts.kanit(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'หาดริ้น',
              style: GoogleFonts.kanit(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            image: Image.asset('assets/images/introductionUI/sni5.jpg'),
            bodyWidget: Text(
              'ไข่แดง',
              style: GoogleFonts.kanit(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'วัดพระใหญ่',
              style: GoogleFonts.kanit(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            image: Image.asset('assets/images/introductionUI/sni6.jpg'),
            bodyWidget: Text(
              'แหล่งธรรมะ',
              style: GoogleFonts.kanit(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        showSkipButton: true,
        skip: Text(
          'ข้าม',
          style: GoogleFonts.kanit(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        onSkip: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginUI(),
          ),
        ),
        dotsDecorator: DotsDecorator(
          size: Size(
            MediaQuery.of(context).size.width * 0.025,
            MediaQuery.of(context).size.height * 0.025,
          ),
          color: Colors.grey,
          activeSize: Size(
            MediaQuery.of(context).size.width * 0.055,
            MediaQuery.of(context).size.height * 0.025,
          ),
          activeColor: Colors.amber,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
        ),
        next: Icon(
          Icons.arrow_forward,
          color: Colors.amber,
        ),
        nextFlex: 0,
        done: Text(
          'เริ่มต้น',
          style: GoogleFonts.kanit(
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        onDone: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginUI(),
          ),
        ),
      ),
    );
  }
}