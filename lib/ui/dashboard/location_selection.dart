import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/widget/common_label.dart';
import 'notification_panel.dart';

class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: CommonLabel(displayText: "Location")),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(
                        size: 30,
                        Icons.location_on_rounded,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'Select location',
                        style: GoogleFonts.cabin(
                          // Use the same font for consistency
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: Container(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationPanel(),
                      ),
                    );
                  },
                  child: Icon(
                    size: 35,
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
