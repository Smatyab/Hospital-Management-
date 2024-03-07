import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/appointment/appo_book_screen.dart';
import 'package:hophseeflutter/ui/doctordetails/doctor_details_sreen.dart';

import '../../data/module/doctor_model.dart';
import 'doctor_card.dart';

class DoctorsListView extends StatelessWidget {
  List<Doctor> data;

  DoctorsListView({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text("Doctor not Available"),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Doctor doctor = data[index];
        return DoctorCard(
          name: "${doctor.doctorName}",
          description: "${doctor.briefDesc}",
          imagePath: doctor.imageUrl ?? "", // Use custom image
          exp: '2 YEARS',
          degree: 'M.B.B.S',
          onTapDetails: () {
            Navigator.pushNamed(context, DoctorDetailScreen.route,
                arguments: doctor);
          },
          onTapAppo: () {
            Navigator.pushNamed(context, AppointmentBookScreen2.route,
                arguments: doctor);
          },
        );
      },
    );
  }
}
