import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/ui/profile/help_design.dart';
import 'package:hophseeflutter/ui/profile/edit_profile_screen.dart';
import 'package:hophseeflutter/ui/profile/setting.dart';

import '../../core/constant.dart';
import '../../core/share_preference.dart';
import '../home/login_screen.dart';

class ProfileDesign extends StatefulWidget {
  const ProfileDesign({Key? key, this.isNotBackArrow = true}) : super(key: key);

  static const route = '/patient_profile_screen';
  final bool isNotBackArrow;

  @override
  State<ProfileDesign> createState() => _ProfileDesignState();
}

class _ProfileDesignState extends State<ProfileDesign> {
  final StreamController<String> _nameController = StreamController<String>();

  Stream<String> get nameStream => _nameController.stream;
  final StreamController<String> _imageController = StreamController<String>();

  Stream<String> get imageStream => _imageController.stream;

  ApiServiceImpl apiService = ApiServiceImpl(Dio());

  @override
  Widget build(BuildContext context) {
    changeData();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            _buildPatientDetails(),
            _buildMedicalHistory(),
            _buildMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      height: 250.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6BB7E1), Color(0xFFAEDFF7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20.h,
            left: 10.w,
            child: widget.isNotBackArrow
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : SizedBox(width: 40.w),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 80.h),
              child: StreamBuilder<String>(
                stream: imageStream,
                builder: (context, snapshot) {
                  return CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    backgroundImage: snapshot.hasData
                        ? NetworkImage(snapshot.data.toString())
                        : AssetImage('assets/doctor.png') as ImageProvider,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<String>(
            stream: nameStream,
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? "Patient Name",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6BB7E1)),
              );
            },
          ),
          SizedBox(height: 12),
          Text(
            "Patient ID: #123456",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailItem("Age", "28"),
              _buildDetailItem("Gender", "Male"),
              _buildDetailItem("Blood Type", "O+"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistory() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Medical History",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6BB7E1)),
          ),
          SizedBox(height: 8),
          Text(
            "Previous surgeries: None\nAllergies: Penicillin\nChronic conditions: Hypertension",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6BB7E1)),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMenuItem("Edit Profile", Icons.edit, _onEditProfilePressed),
        _buildMenuItem("Settings", Icons.settings, () {
          //showSnackbar(context, "Coming soon...");
          Navigator.pushNamed(context, SettingsPage.route);
        }),
        _buildMenuItem("Help", Icons.help_outline_sharp, () {
          Navigator.pushNamed(context, HelpMePage.route);
        }),
        _buildMenuItem("Logout", Icons.logout, () {
          Preference.clearData();
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.route, (route) => false);
        }),
      ],
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onPressed) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: 8,
        intensity: 0.7,
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        onTap: onPressed,
        leading: Icon(icon, color: Color(0xFF6BB7E1)),
        title: Text(title,
            style: TextStyle(fontSize: 18, color: Color(0xFF6BB7E1))),
        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF6BB7E1)),
      ),
    );
  }

  void changeData() async {
    Map<String, String?> value =
        await Preference.getUserDetailsFromSharedPreferences();
    _nameController.sink.add(value["name"].toString());
    String imageUrl = value["image_url"].toString();
    _imageController.sink.add(imageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.close();
    _imageController.close();
  }

  void _onEditProfilePressed() async {
    bool isDoctor =
        await Preference.getValueFromSharedPreferences(IS_DOCTOR_PREFERENCE);
    Navigator.pushNamed(
      context,
      EditProfileScreen.route,
      arguments: isDoctor,
    );

    /* Uncomment the following code if you need to fetch additional data
    int userId = await Preference.getValueFromSharedPreferences(
      USER_ID_PREFERENCE);
    print("user : $userId");
    apiService.getUserById(userId).then(
      (value) {
        Navigator.pushNamed(
          context, EditProfileScreen.route,
          arguments: value.data?[0],
        );
      },
      onError: (error) {
        showSnackbar(context, "Something went wrong..");
      },
    );
    */
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
