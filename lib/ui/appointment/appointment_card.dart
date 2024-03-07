import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/core/utils.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/data/module/user_model.dart';

import '../../data/module/appo_model.dart';

class AppointmentCard extends StatefulWidget {
  final String appoDate;
  final String appoTime;
  final String doctorName;
  Function()? onRemoveClick;

  AppointmentCard(
      {
      /* required this.user, required this.doctor*/
      required this.appoDate,
      required this.appoTime,
      required this.doctorName,
      required this.onRemoveClick});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doctor: ${widget.doctorName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Customize the text color
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${widget.appoDate}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey, // Customize the text color
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Time: ${widget.appoTime}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey, // Customize the text color
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: widget.onRemoveClick,
              child: Image.asset(
                "assets/ic_close.png",
                height: 40,
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}