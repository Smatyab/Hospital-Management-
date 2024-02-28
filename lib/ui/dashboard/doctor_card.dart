import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant.dart';
import '../appointment/appo_book_screen.dart';

class DoctorCard extends StatelessWidget {
  DoctorCard({
    Key? key,
    required this.name,
    required this.description,
    required this.exp,
    required this.degree,
    required this.imagePath,
    required this.onTapDetails,
    required this.onTapAppo,
    this.DetailButton = true,
    this.AppoButton = true,
  }) : super(key: key);

  final String name;
  final String description;
  final String exp;
  String degree;
  final String imagePath;
  final VoidCallback onTapDetails;
  final VoidCallback onTapAppo;
  bool DetailButton;
  bool AppoButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "$host/$imagePath",
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              /*Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),*/
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                'Exp: $exp',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Degree: $degree',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (DetailButton)
                ElevatedButton(
                  onPressed: onTapDetails,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              if (AppoButton)
                ElevatedButton(
                  onPressed: onTapAppo,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  ),
                  child: Text(
                    'Get Appointment',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
