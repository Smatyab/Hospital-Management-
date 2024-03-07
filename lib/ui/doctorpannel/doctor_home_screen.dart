import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/appointment/appointment_list_screen.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_dashboard.dart';
import '../appointment/appointment_book_screen.dart';
import '../doctordetails/doctor_list_screen.dart';
import '../profile/profile_design.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);
  static const route = '/doctor_home_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<DoctorHomeScreen> {
  final items = const [
    Icon(
      Icons.home_outlined,
      size: 30,
    ),
    Icon(
      Icons.person_outline,
      size: 30,
    )
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: getSelectedWidget(index: index),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIdx) {
          setState(() {
            index = selectedIdx;
          });
        },
        height: 60,
        color: Colors.lightBlueAccent,
        // Set the color to blue
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = DoctorDashboardScreen();
        break;
      case 1:
        widget = ProfileDesign(isNotBackArrow: false);
        break;
      default:
        widget = DoctorDashboardScreen();
        break;
    }
    return widget;
  }
}
