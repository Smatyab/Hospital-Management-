import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/route_generator.dart';
import 'package:hophseeflutter/ui/appointment/appo_book_screen.dart';
import 'package:hophseeflutter/ui/dashboard/user_home_screen.dart';
import 'package:hophseeflutter/ui/doctordetails/doctor_details_sreen.dart';
import 'package:hophseeflutter/ui/home/login_screen.dart';

void main() {
  runApp(DevicePreview(
    builder: (BuildContext c) {
      return MyApp();
    },
    enabled: !kReleaseMode,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Set the default theme to light
        // Define other theme properties like colors, text styles, etc.
      ),
      /*darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Set the dark theme
        // Define dark theme properties.
      ),*/
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      //home: LoginScreen(),
    );
  }
}
