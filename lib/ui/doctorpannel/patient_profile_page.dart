import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constant.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/patient_model.dart';

class PatientInfoPage extends StatefulWidget {
  static const route = '/patient_Info_page';
  int patientId;

  PatientInfoPage({super.key, required this.patientId});

  @override
  State<PatientInfoPage> createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  final StreamController<Patient?> _controller = StreamController<Patient?>();
  Stream<Patient?> get stream => _controller.stream;

  Patient? patient;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (patient == null) {
      apiService.getPatient(widget.patientId).then(
        (value) {
          if (value.error == 0 && value.data?.isNotEmpty == true) {
            patient = value.data?[0];
            _controller.sink.add(patient);
          } else {
            _controller.sink.add(null);
          }
        },
        onError: (error) {
          print(error);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<Patient?>(
                stream: stream, // Access the custom stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Patient? patientInfo = snapshot.data;
                    if (patientInfo == null) {
                      return const Center(
                        child: Text(
                          "Something went wrong",
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 120, // Adjust according to your design
                                height: 120, // Adjust according to your design
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              ClipOval(
                                child: Container(
                                  width: 100, // Adjust according to your design
                                  height:
                                      100, // Adjust according to your design
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "$host/${patient?.imageUrl ?? " "}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${patientInfo.patientName}",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6BB7E1)),
                              ),
                              Divider(),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Patient Information",
                                        style: GoogleFonts.adamina(
                                          fontSize: 20.sp,
                                          color: Color(0xFF6BB7E1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Column(children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Gender",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6BB7E1)),
                                            ),
                                            Text(
                                              "${patientInfo.gender}",
                                              style: GoogleFonts.adamina(
                                                fontSize: 15.sp,
                                                color: Color(0xFF6BB7E1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "D.O.B",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6BB7E1)),
                                            ),
                                            Text(
                                              "${patientInfo.dateOfBirth}",
                                              style: GoogleFonts.adamina(
                                                fontSize: 15.sp,
                                                color: Color(0xFF6BB7E1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Email",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.emailId}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Phone Number",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.phoneNo}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              Divider(),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Health Information",
                                        style: GoogleFonts.adamina(
                                          fontSize: 20.sp,
                                          color: Color(0xFF6BB7E1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Column(children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Height",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6BB7E1)),
                                            ),
                                            Text(
                                              "${patientInfo.height}",
                                              style: GoogleFonts.adamina(
                                                fontSize: 15.sp,
                                                color: Color(0xFF6BB7E1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Weight",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6BB7E1)),
                                            ),
                                            Text(
                                              "${patientInfo.weight}",
                                              style: GoogleFonts.adamina(
                                                fontSize: 15.sp,
                                                color: Color(0xFF6BB7E1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Blood Group",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.bloodGroup}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Allergies",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.allegeries}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Diseases",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.diseases}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Blood Pressure",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.bloodPressure}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Body Temperature",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.bodyTemp}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Blood Level",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.bloodLevel}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Heart Rate",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.heartRate}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Glucose Rate",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.glucoseRate}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Cholesterol Level",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                                Text(
                                                  "${patientInfo.colestrol}",
                                                  style: GoogleFonts.adamina(
                                                    fontSize: 15.sp,
                                                    color: Color(0xFF6BB7E1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              Divider(),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Account Information",
                                        style: GoogleFonts.adamina(
                                          fontSize: 20.sp,
                                          color: Color(0xFF6BB7E1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Column(children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Last Login",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6BB7E1)),
                                            ),
                                            Text(
                                              "${patientInfo.lastLogin}",
                                              style: GoogleFonts.adamina(
                                                fontSize: 15.sp,
                                                color: Color(0xFF6BB7E1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Last Update",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6BB7E1)),
                                            ),
                                            Text(
                                              "${patientInfo.updateDt}",
                                              style: GoogleFonts.adamina(
                                                fontSize: 15.sp,
                                                color: Color(0xFF6BB7E1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: Text("Please wait.."),
                  );
                },
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
