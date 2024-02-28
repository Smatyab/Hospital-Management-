import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hophseeflutter/core/utils.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/ui/dashboard/doctors_list_view.dart';

import '../../core/widget/custome_app_bar.dart';
import '../dashboard/dashboard.dart';
import '../profile/profile_design.dart';

class DoctorListScreen extends StatefulWidget {
  DoctorList? doctorList;
  bool isBack;
  static const route = '/doctor_list_screen';

  DoctorListScreen({this.doctorList, this.isBack = true, super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final StreamController<DoctorList?> _controller =
      StreamController<DoctorList?>();

  // Getter to get the stream associated with this controller.
  Stream<DoctorList?> get stream => _controller.stream;

  void doctorList(BuildContext context) async {
    if (widget.doctorList == null) {
      widget.doctorList = await ApiServiceImpl(Dio()).getDoctorList();
    }
    print("DoctorList : ${widget.doctorList}");
    _controller.sink.add(widget.doctorList);
  }

  @override
  Widget build(BuildContext context) {
    doctorList(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<DoctorList?>(
                stream: stream, // Access the custom stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: DoctorsListView(
                        data: (snapshot.data)?.data ?? [],
                      ),
                    );
                  } else {
                    return const Center(child: Text("Please wait..."));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
