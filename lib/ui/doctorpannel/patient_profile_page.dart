import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widget/custome_app_bar.dart';
import '../../data/module/patient_model.dart';

class PatientInfoPage extends StatefulWidget {
  static const route = '/patient_Info_page';

  Patient? patient;

  PatientInfoPage({super.key});

  @override
  State<PatientInfoPage> createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar2(backBtn: false, label: 'Patient Informatio'),
            Divider(),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
