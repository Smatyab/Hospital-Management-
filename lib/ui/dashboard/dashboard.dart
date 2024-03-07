import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/widget/common_label.dart';
import 'package:hophseeflutter/core/widget/common_label_with_tap.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/ui/dashboard/custom_ad.dart';
import 'package:hophseeflutter/ui/dashboard/doctor_category_list.dart';
import 'package:hophseeflutter/ui/dashboard/doctors_list_view.dart';
import 'package:hophseeflutter/ui/dashboard/location_selection.dart';
import '../doctordetails/doctor_list_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  DoctorList? doctorList;
  final StreamController<DoctorList?> _controller =
      StreamController<DoctorList?>();

  // Getter to get the stream associated with this controller.
  Stream<DoctorList?> get stream => _controller.stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (doctorList == null) {
      apiService.getDoctorList().then(
        (value) {
          doctorList = value;
          _controller.sink.add(doctorList);
        },
        onError: (error) {
          print(error);
        },
      );
    } else {
      _controller.sink.add(doctorList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LocationSelectionScreen(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: CommonLabel(displayText: "Categories")),
              const SizedBox(
                height: 10,
              ),
              const DoctorCategoryList(),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              StreamBuilder<DoctorList?>(
                stream: stream, // Access the custom stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int numberOfIterate = 0;
                    if ((snapshot.data?.data?.length ?? 0) < 3) {
                      numberOfIterate = snapshot.data?.data?.length ?? 0;
                    } else {
                      numberOfIterate = 3;
                    }
                    ;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CommonLabel(displayText: "All Doctors"),
                              CommonLabelWithTap(
                                text: "SEE ALL",
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  Navigator.pushNamed(
                                      context, DoctorListScreen.route,
                                      arguments: snapshot.data);
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: double.infinity,
                          height: 170.h,
                          child: DoctorsListView(
                            data: snapshot.data?.data
                                    ?.sublist(0, numberOfIterate) ??
                                [],
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: Text("Please wait.."),
                  );
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              const Divider(),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: CommonLabel(displayText: "About Us")),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: AdvertisementCard(),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
