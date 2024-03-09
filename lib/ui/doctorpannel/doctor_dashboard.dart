import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/utils.dart';
import 'package:hophseeflutter/data/module/user_model.dart';
import 'package:hophseeflutter/ui/doctorpannel/appo_item_card.dart';

import '../../core/constant.dart';
import '../../core/share_preference.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/appo_model.dart';
import '../dashboard/location_selection.dart';

class DoctorDashboardScreen extends StatefulWidget {
  static const route = '/doctor_dashboard_screen';

  AppoList? appoList;

  @override
  _DoctorDashboardScreenState createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  final StreamController<Map<String, dynamic>?> _controller =
      StreamController<Map<String, dynamic>?>();

  Stream<Map<String, dynamic>?> get stream => _controller.stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.appoList == null) {
      Preference.getValueFromSharedPreferences(DOCTOR_ID_PREFERENCE)
          .then((value) {
        apiService.getAppoList(doctorId: value).then(
          (value) {
            Map<String, dynamic> data = {};
            widget.appoList = value;
            data["appolist"] = value.toJson();
            List<Appo>? appoList = value.data;
            if (value.error == 0 && appoList != null && appoList.isNotEmpty) {
              apiService.getUserList().then((value) {
                data["userList"] = value.toJson();
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

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const CustomAppBar(backBtn : false),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child:
              ),
            ),
          ],
        ),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //const CustomAppBar(backBtn: false),
            LocationSelectionScreen(),
            Expanded(
              child: StreamBuilder<Map<String, dynamic>?>(
                stream: stream, // Access the custom stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic>? data = snapshot.data;
                    if (data?["isEmptyData"] == true) {
                      return const Center(
                        child: Text("Empty Appointment"),
                      );
                    }
                    List<Appo>? appoList =
                        AppoList.fromJson(data?["appolist"]).data;
                    print("length of list : ${appoList?.length}");
                    if (appoList != null && appoList.isNotEmpty) {
                      List<User>? userList =
                          UserModel.fromJson(data?["userList"]).data;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(0),
                        itemCount: appoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Appo? appo = appoList[index];
                          User? user = userList?.firstWhere((obj) =>
                                  obj.userId ==
                                  appo.userId // Provide a default value if the object is not found
                              );
                          return AppoItemCard(
                            name: "${user?.userName}",
                            date: getENDate("${appo.appoDt}"),
                            time: "${appo.appoTime}",
                            imagePath: user?.imageUrl ?? "",
                            email: "${user?.emailId}",
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("Empty Appointment"),
                      );
                    }
                  }
                  return const Center(
                    child: Text("Please wait.."),
                  );
                },
              ),
            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }
}
