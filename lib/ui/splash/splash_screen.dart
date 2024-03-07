import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hophseeflutter/core/constant.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_home_screen.dart';
import 'package:hophseeflutter/ui/home/login_screen.dart';
import 'package:hophseeflutter/ui/welcomescreen/WelcomeScreen.dart';

import '../../core/share_preference.dart';
import '../../core/utils.dart';
import '../dashboard/user_home_screen.dart';
import '../doctorpannel/doctor_dashboard.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void displayContent(BuildContext context) async {
    Map<String, dynamic> data = await Preference.getLoginConfig();
    String navigator = data[IS_LOGIN_PREFERENCE]
        ? data[IS_DOCTOR_PREFERENCE]
            ? DoctorHomeScreen.route
            : UserHomeScreen.route
        : WelcomeScreen.route;
    Navigator.pushNamedAndRemoveUntil(context, navigator, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    delay(5).then((_) {
      displayContent(context);
    });
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              "assets/applogo.png",
              scale: 2,
            ),
            /*Text(
              'HoPhSee',
              style: GoogleFonts.lato(
                // Use the same font for consistency
                fontSize: 18,
                color: Colors.black, // Change the text color
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
