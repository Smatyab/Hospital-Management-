import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/widget/common_label.dart';
import 'package:hophseeflutter/ui/profile/profile_design.dart';

import '../share_preference.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key? key,
    this.backBtn = true,
  }) : super(key: key);
  final bool backBtn;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final StreamController<String> _controller = StreamController<String>();

  // Getter to get the stream associated with this controller.
  Stream<String> get stream => _controller.stream;

  final StreamController<String> _image_controller = StreamController<String>();

  // Getter to get the stream associated with this controller.
  Stream<String> get image_stream => _image_controller.stream;

  @override
  Widget build(BuildContext context) {
    changeData();
    return Container(
      height: 40.h,
      width: double.infinity,
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (widget.backBtn)
            InkWell(
              child: const Icon(Icons.arrow_back_outlined),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          StreamBuilder<String>(
            stream: stream, // Access the custom stream
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data.toString(),
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                );
              } else {
                return const Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                );
              }
            },
          ),
          const SizedBox(width: 16.0),
          StreamBuilder<String>(
            stream: image_stream, // Access the custom stream
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ProfileDesign.route);
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue, // Border color
                        width: 3.0, // Border width
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(snapshot.data.toString()),
                    ),
                  ),
                );
              } else {
                return const Text(
                  "Image",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                );
              }
            },
          )
        ],
      ),
    );
  }

  void changeData() async {
    Map<String, String?> value =
        await Preference.getUserDetailsFromSharedPreferences();
    print("Name Of the user $value");
    _controller.sink.add(value["name"].toString());
    String imageUrl = value["image_url"].toString();
    print("image_url : $imageUrl");
    _image_controller.sink.add(imageUrl);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.close();
    _image_controller.close();
  }
}

class CustomAppbar2 extends StatefulWidget {
  const CustomAppbar2({
    Key? key,
    required this.label,
    this.backBtn = true,
  }) : super(key: key);
  final bool backBtn;
  final String label;

  @override
  _CustomAppbar2State createState() => _CustomAppbar2State();
}

class _CustomAppbar2State extends State<CustomAppbar2> {
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 15,
          top: 0,
          child: Column(
            children: [
              if (widget.backBtn)
                InkWell(
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    size: 25,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(child: CommonLabel(displayText: widget.label)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
