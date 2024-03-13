import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../../core/constant.dart';
import '../../core/share_preference.dart';
import '../../core/utils.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/appo_model.dart';
import '../../data/module/doctor_model.dart';
import 'appointment_card.dart';

class Appointment {
  final String title;
  final String date;
  final String time;
  final String doctor;

  final String status;

  const Appointment({
    required this.title,
    required this.date,
    required this.time,
    required this.doctor,
    required this.status,
  });
}

class AppointmentScheduler extends StatefulWidget {
  @override
  _AppointmentSchedulerState createState() => _AppointmentSchedulerState();
  List<Appo>? appoList;
  List<Doctor>? doctorList;
  int? userId;
}

class _AppointmentSchedulerState extends State<AppointmentScheduler> {
  int _tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("call initstate");
    if (widget.userId == null) {
      Preference.getValueFromSharedPreferences(USER_ID_PREFERENCE)
          .then((value) {
        widget.userId = value;
        print("userId : ${widget.userId}");
        setAppoList(APPO_TYPE_UPCOMING);
      });
    }
  }

  final StreamController<Map<String, dynamic>> _controller =
      StreamController<Map<String, dynamic>>();

  // Getter to get the stream associated with this controller.
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  ApiServiceImpl apiServices = ApiServiceImpl(Dio());

  void setAppoList(String type) {
    widget.appoList?.clear();
    apiServices.getAppoListByType(userId: widget.userId, type: type).then(
      (value) {
        List<Appo>? appoList = value.data;
        print("object ${appoList.toString()}");
        if (value.error == 0 && appoList != null && appoList.isNotEmpty) {
          widget.appoList = value.data;
          if (widget.doctorList == null) {
            apiServices.getDoctorList().then((value) {
              if (value.error == 0) {
                widget.doctorList = value.data;
              }
            }, onError: (error) {
              print(error);
            });
          }
          _controller.sink.add({"type": type});
        } else {
          _controller.sink.add({"type": "Error"});
        }
      },
      onError: (error) {
        print(error);
        _controller.sink.add({"type": "Error"});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTabButton(0, APPO_TYPE_UPCOMING),
                    SizedBox(width: 8), // Add space between tabs
                    buildTabButton(1, APPO_TYPE_APPROVED),
                    SizedBox(width: 8), // Add space between tabs
                    buildTabButton(2, APPO_TYPE_CANCELLED),
                    SizedBox(width: 8), // Add space between tabs
                    buildTabButton(3, APPO_TYPE_EXPIRED),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<Map<String, dynamic>>(
                stream: stream, // Access the custom stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic>? data = snapshot.data;
                    String type = data?["type"];
                    switch (type) {
                      case APPO_TYPE_UPCOMING:
                        /* return const Center(
                          child: Text("Upcoming..."),
                        );*/
                        return setListView();
                        break;
                      case APPO_TYPE_APPROVED:
                        print("approved");
                        return setListView();
                        /*    return const Center(
                          child: Text("Approved..."),
                        );*/
                        break;
                      case APPO_TYPE_CANCELLED:
                        return setListView();
                        /*   return const Center(
                          child: Text("Cancelled..."),
                        );*/
                        break;
                      case APPO_TYPE_EXPIRED:
                        return setListView();
                        /*     return const Center(
                          child: Text("Expired..."),
                        );*/
                        break;
                      default:
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                    }
                  }
                  return const Center(
                    child: Text("Loading..."),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setListView() {
    print("approved ${widget.appoList.toString()}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.appoList?.length,
          itemBuilder: (BuildContext context, int index) {
            Appo? appo = widget.appoList?[index];
            Doctor? doctor = widget.doctorList?.firstWhere((obj) =>
                    obj.doctorId ==
                    appo?.doctorId // Provide a default value if the object is not found
                );
            return AppointmentCard(
                appoDate: convertIsoToIndianDate(appo?.appoDt ?? ""),
                appoTime: appo?.appoTime ?? "",
                doctorName: doctor?.doctorName ?? "",
                /*doctorName: "",*/
                isRemoveBtnView: _tabIndex == 0,
                onRemoveClick: () {
                  showSnackbar(context, "Delete Tap");
                  ApiServiceImpl(Dio())
                      .removeAppointment(appo?.appoId ?? -1)
                      .then((value) {
                    if (value.error == 0) {
                      showSnackbar(context, "Remove succesfully");
                      setState(() {});
                    } else {
                      showSnackbar(context, "Something went wrong");
                    }
                  });
                });
          },
        ),
      ],
    );
  }

  Widget buildTabButton(int index, String label) {
    bool isSelected = _tabIndex == index;

    return NeumorphicButton(
      onPressed: () {
        setState(() {
          _tabIndex = index;
          setAppoList(label);
        });
      },
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        depth: isSelected ? 3 : 5,
        lightSource: isSelected ? LightSource.topLeft : LightSource.top,
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : Colors.black87,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 2,
              width: 60, // You can adjust the width of the line
              color: Colors.blueAccent,
            ),
        ],
      ),
    );
  }
}
