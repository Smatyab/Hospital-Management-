import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:hophseeflutter/ui/appointment/appointment_type.dart';

import '../doctordetails/doctor_list_screen.dart';
import '../profile/profile_design.dart';
import 'dashboard.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);
  static const route = '/user_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<UserHomeScreen> {
  final List<Widget> screens = [
    const MyHome(),
    DoctorListScreen(isBack: false),
    AppointmentScheduler(),
    /*
    AppointmentListScreen(appoList: null),*/
    const ProfileDesign(isNotBackArrow: false),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.white],
            //colors: [Colors.lightBlueAccent.shade400, Colors.white60],
          ),
        ),
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: -8,
            intensity: 0.7,
            color: Colors.transparent,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          child: screens[selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.white]),
        ),
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: 8,
            intensity: 0.7,
            color: Colors.transparent,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(24),
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                screens.length,
                (index) => NeumorphicButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12),
                    ),
                    depth: 4,
                    intensity: 0.5,
                    lightSource: LightSource.topLeft,
                    color: selectedIndex == index
                        ? Colors.lightBlueAccent.shade400
                        : Colors.transparent,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    index == 0
                        ? Icons.home_outlined
                        : index == 1
                            ? Icons.list_alt
                            : index == 2
                                ? Icons.calendar_today
                                : Icons.person_outline,
                    size: 24,
                    color: selectedIndex == index
                        ? Colors.white
                        : Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/appointment/appointment_list_screen.dart';
import '../doctordetails/doctor_list_screen.dart';
import '../profile/profile_design.dart';
import 'dashboard.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);
  static const route = '/user_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<UserHomeScreen> {
  final List<Widget> screens = [
    const MyHome(),
    DoctorListScreen(isBack: false),
    AppointmentListScreen(appoList: null),
    const ProfileDesign(isNotBackArrow: false),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
*/
