import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hophseeflutter/core/widget/custome_app_bar.dart';
import 'package:hophseeflutter/ui/appointment/appo_book_screen.dart';
import 'package:hophseeflutter/ui/appointment/appointment_list_screen.dart';
import 'package:hophseeflutter/ui/dashboard/doctor_card.dart';
import 'package:hophseeflutter/ui/doctordetails/doctor_details_card.dart';

import '../../core/extfunction.dart';
import '../../data/module/doctor_model.dart';
import '../appointment/appointment_book_screen.dart';

class DoctorDetailScreen extends StatefulWidget {
  final Doctor doctor;
  DoctorDetailScreen({super.key, required this.doctor});

  static const route = '/doctordetails';

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomAppbar2(
                    label: 'Doctor Detail',
                  ),
                  Divider(),
                  /*DoctorCard2(
                    name: 'widget.doctor.doctorName ?? ""',
                  ),*/
                  DoctorCard(
                    name: widget.doctor.doctorName ?? "",
                    description: widget.doctor.briefDesc ?? "",
                    imagePath: widget.doctor.imageUrl ?? "",
                    DetailButton: false,
                    AppoButton: false,
                    exp: '',
                    degree: '',
                    onTapDetails: () {},
                    onTapAppo: () {},
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Neumorphic(
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                depth: 4,
                                intensity: 0.5,
                                lightSource: LightSource.topLeft,
                              ),
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                color: HexColor.fromHex("1C2A3A"),
                                child: Icon(
                                  size: 30.sp,
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '200+',
                              style: GoogleFonts.alata(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Patients',
                              style: GoogleFonts.abel(
                                fontSize: 15.sp,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Neumorphic(
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                depth: 4,
                                intensity: 0.5,
                                lightSource: LightSource.topLeft,
                              ),
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                color: HexColor.fromHex("1C2A3A"),
                                child: Icon(
                                  size: 30.sp,
                                  Icons.workspace_premium_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '2 years',
                              style: GoogleFonts.alata(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'experience',
                              style: GoogleFonts.abel(
                                fontSize: 15.sp,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Neumorphic(
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                depth: 4,
                                intensity: 0.5,
                                lightSource: LightSource.topLeft,
                              ),
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                color: HexColor.fromHex("1C2A3A"),
                                child: Icon(
                                  size: 30.sp,
                                  Icons.star,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '5',
                              style: GoogleFonts.alata(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Rating',
                              style: GoogleFonts.abel(
                                fontSize: 15.sp,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Neumorphic(
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                depth: 4,
                                intensity: 0.5,
                                lightSource: LightSource.topLeft,
                              ),
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                color: HexColor.fromHex("1C2A3A"),
                                child: Icon(
                                  size: 30.sp,
                                  Icons.chat_bubble,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '2123',
                              style: GoogleFonts.alata(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Reviews',
                              style: GoogleFonts.abel(
                                fontSize: 15.sp,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 3),
                          child: Row(
                            children: [
                              Text(
                                'About Me',
                                style: GoogleFonts.alata(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 3),
                          child: Row(
                            children: [
                              Text(
                                'Dr.david patel, a dedicated cardiologist,brings a wealth \nof experience to golden gate cardiology center in \ngloden gate, CA.',
                                style: GoogleFonts.abel(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 3),
                          child: Row(
                            children: [
                              Text(
                                'Working Time',
                                style: GoogleFonts.alata(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 3),
                          child: Row(
                            children: [
                              Text(
                                'Committed to Care, Available for You: Healing Lives,\nOne Appointment at a Time.',
                                style: GoogleFonts.abel(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 3),
                          child: Row(
                            children: [
                              Text(
                                'Recents Reviews',
                                style: GoogleFonts.alata(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ReviewCard(),
                ],
              ),
              /*Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: NeumorphicButton(
                  onPressed: () {
                    */ /*Navigator.pushNamed(context, AppointmentBookScreen2.route,
                        arguments: doctor);*/ /*
                  },
                  style: NeumorphicStyle(
                    color: Colors.lightBlueAccent.shade200,
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(25),
                    ),
                    depth: 8,
                    intensity: 0.7,
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 3.h, horizontal: 20.w),
                    child: Text(
                      'Book your Appointment',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
