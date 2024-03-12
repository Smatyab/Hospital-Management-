import 'package:dio/dio.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils.dart';
import '../../data/datasource/api_services.dart';
import '../doctordetails/doctor_list_screen.dart';

class DoctorCategoryList extends StatelessWidget {
  const DoctorCategoryList({Key? key});

  @override
  Widget build(BuildContext context) {
    ApiServiceImpl apiService = ApiServiceImpl(Dio());

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            const SizedBox(height: 12),
            SingleChildScrollView(
              child: Row(
                children: getDoctorCategories()
                    .map(
                      (e) => TextButton(
                        onPressed: () {
                          apiService.getDoctorList().then((value) {
                            Navigator.pushNamed(context, DoctorListScreen.route,
                                arguments: value);
                          }, onError: (error) {
                            print(error);
                          });
                        },
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 4,
                            intensity: 0.5,
                            lightSource: LightSource.topLeft,
                          ),
                          child: Container(
                            height: 42.h,
                            decoration: BoxDecoration(
                              //color: HexColor.fromHex("#E0EBFF"),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 2.0,
                                  bottom: 2.0),
                              child: Center(
                                child: Text(
                                  e.Text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
