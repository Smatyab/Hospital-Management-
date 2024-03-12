import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/core/constant.dart';
import 'package:hophseeflutter/core/share_preference.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/appo_model.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/ui/appointment/appointment_type.dart';

import '../../core/utils.dart';
import '../../core/widget/custome_app_bar.dart';
import 'appointment_card.dart';

class AppointmentListScreen extends StatefulWidget {
  AppointmentListScreen({super.key, this.appoList});

  static const route = '/appointment_list_screen';

  AppoList? appoList;

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  ApiServiceImpl apiServices = ApiServiceImpl(Dio());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.appoList == null) {
      Preference.getValueFromSharedPreferences(USER_ID_PREFERENCE)
          .then((value) {
        print("object $value");

        apiServices.getAppoList(userId: value).then(
          (value) {
            print("object ${value.toString()}");

            Map<String, dynamic> data = {};
            widget.appoList = value;
            data["appolist"] = value.toJson();
            List<Appo>? appoList = value.data;
            print("object ${appoList.toString()}");
            if (value.error == 0 && appoList != null && appoList.isNotEmpty) {
              apiServices.getDoctorList().then((value) {
                data["doctorList"] = value.toJson();
                _controller.sink.add(data);
              }, onError: (error) {
                print(error);
              });
            } else {
              _controller.sink.add({"isEmptyData": true});
            }
          },
          onError: (error) {
            print(error);
          },
        );
      });
    }
  }

  final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>();

  // Getter to get the stream associated with this controller.
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbar2(
                backBtn: false,
                label: 'My Appointments',
              ),
              AppointmentScheduler(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<Map<String, dynamic>>(
                  stream: stream, // Access the custom stream
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic>? data = snapshot.data;
                      print("object $data");
                      if (data?["isEmptyData"] == true) {
                        return const Center(
                          child: Text("Empty Appoinment"),
                        );
                      }
                      List<Appo>? appoList =
                          AppoList.fromJson(data?["appolist"]).data;
                      if (appoList != null && appoList.isNotEmpty) {
                        List<Doctor>? doctorList =
                            DoctorList.fromJson(data?["doctorList"]).data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: appoList.length,
                              itemBuilder: (BuildContext context, int index) {
                                Appo? appo = appoList[index];
                                Doctor? doctor = doctorList?.firstWhere((obj) =>
                                        obj.doctorId ==
                                        appo.doctorId // Provide a default value if the object is not found
                                    );
                                return AppointmentCard(
                                    appoDate: convertIsoToIndianDate(
                                        appo.appoDt ?? ""),
                                    appoTime: appo.appoTime ?? "",
                                    doctorName: doctor?.doctorName ?? "",
                                    isRemoveBtnView: true,
                                    onRemoveClick: () {
                                      showSnackbar(context, "Delete Tap");
                                      ApiServiceImpl(Dio())
                                          .removeAppointment(appo.appoId ?? -1)
                                          .then((value) {
                                        if (value.error == 0) {
                                          showSnackbar(
                                              context, "Remove succesfully");
                                          setState(() {});
                                        } else {
                                          showSnackbar(
                                              context, "Something went wrong");
                                        }
                                      });
                                    });
                              },
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text("Empty Appointment"),
                        );
                      }
                    } else {
                      return Center(
                        child: Text("Loading..."),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
