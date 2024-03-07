import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class Appointment {
  final String title;
  final String date;
  final String time;
  final String doctor;

  final String status;

  const Appointment({
    required this.title,
    required this.date,
    required this.time,
    required this.doctor,
    required this.status,
  });
}

class AppointmentScheduler extends StatefulWidget {
  @override
  _AppointmentSchedulerState createState() => _AppointmentSchedulerState();
}

class _AppointmentSchedulerState extends State<AppointmentScheduler> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTabButton(0, "Upcoming"),
                SizedBox(width: 8), // Add space between tabs
                buildTabButton(1, "Approved"),
                SizedBox(width: 8), // Add space between tabs
                buildTabButton(2, "Canceled"),
                SizedBox(width: 8), // Add space between tabs
                buildTabButton(3, "Expired"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabButton(int index, String label) {
    bool isSelected = _tabIndex == index;

    return NeumorphicButton(
      onPressed: () {
        setState(() {
          _tabIndex = index;
        });
      },
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        depth: isSelected ? 3 : 5,
        lightSource: isSelected ? LightSource.topLeft : LightSource.top,
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : Colors.black87,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 2,
              width: 60, // You can adjust the width of the line
              color: Colors.blueAccent,
            ),
        ],
      ),
    );
  }
}
