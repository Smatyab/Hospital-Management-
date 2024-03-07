import 'package:flutter/material.dart';

import '../../core/constant.dart';

class AppoItemCard extends StatelessWidget {
  const AppoItemCard({
    Key? key,
    required this.name,
    required this.imagePath, required this.date, required this.time, required this.email,
  }) : super(key: key);

  final String name;
  final String date;
  final String time;
  final String email;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: NetworkImage("$host/$imagePath"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name : $name",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Date: $date',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey, // Customize the text color
                  ),
                ),
                Text(
                  'Time: $time',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey, // Customize the text color
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Email : $email",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                   /* Text(
                      age,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}