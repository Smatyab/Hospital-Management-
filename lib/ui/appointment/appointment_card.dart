import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant.dart';

class AppointmentCard extends StatefulWidget {
  final String appoDate;
  final String imagePath;
  final String appoTime;
  final String doctorName;
  final bool isRemoveBtnView;
  Function()? onRemoveClick;

  AppointmentCard(
      {super.key,
      /* required this.user, required this.doctor*/
      required this.appoDate,
      required this.imagePath,
      required this.appoTime,
      required this.doctorName,
      required this.onRemoveClick,
      required this.isRemoveBtnView});

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
            Container(
              width: 65.w,
              height: 65.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage("$host/${widget.imagePath}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
            removeBtn(widget.isRemoveBtnView)
          ],
        ),
      ),
    );
  }

  Widget removeBtn(bool? isBtnView) {
    if (isBtnView == true) {
      return InkWell(
        onTap: widget.onRemoveClick,
        child: Icon(
          Icons.cancel, // Use a suitable icon from the Material Design library
          size: 30, // Adjust size as needed
          color: Colors.black, // Customize color if desired
        ),
      );
    } else {
      return const SizedBox(height: 0, width: 0);
    }
  }
}
