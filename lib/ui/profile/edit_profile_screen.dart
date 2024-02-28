import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/constant.dart';
import 'package:hophseeflutter/core/share_preference.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/data/module/user_model.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../core/utils.dart';

class EditProfileScreen extends StatefulWidget {
  static const route = '/edit_profile_screen';
  bool isDoctor;

  EditProfileScreen({super.key, required this.isDoctor});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? user;
  Doctor? doctor;

  ApiServiceImpl apiService = ApiServiceImpl(Dio());

  String name = "";
  String mobileNumber = '';
  String emailAddress = '';
  String gender = 'Male'; // Default gender value
  String profilePhotoUrl = 'assets/pimage.png'; // Profile photo URL

  // Store the previous values for canceling changes
  String prevName = '';
  String prevMobileNumber = '';
  String prevEmailAddress = '';
  String prevGender = 'Male';

  final Map<String, IconData> leadingIcons = {
    'Name': Icons.person,
    'Mobile Number': Icons.phone,
    'Email Address': Icons.email,
    'Gender': LineAwesomeIcons.genderless,
  };

  @override
  void initState() {
    super.initState();
    // Initialize previous values
    if (widget.isDoctor) {
      Preference.getValueFromSharedPreferences(DOCTOR_ID_PREFERENCE)
          .then((value) {
        apiService.getDoctorById(value).then((value) {
          /*Navigator.pushNamed(
                  context, EditProfileScreen.route,
                  arguments: value.data?[0]);*/
          setState(() {
            doctor = value.data?[0];
            name = doctor?.doctorName ?? "";
            mobileNumber = doctor?.phoneNo ?? "";
            emailAddress = doctor?.emailId ?? "";
            gender = doctor?.gender == "M" ? "Male" : "Female" ?? "";
          });
        }, onError: (error) {
          showSnackbar(context, "Something went wrong..");
        });
      });
    } else {
      Preference.getValueFromSharedPreferences(USER_ID_PREFERENCE)
          .then((value) {
        apiService.getUserById(value).then((value) {
          /*Navigator.pushNamed(
                  context, EditProfileScreen.route,
                  arguments: value.data?[0]);*/
          setState(() {
            user = value.data?[0];
            name = user?.userName ?? "";
            mobileNumber = user?.phoneNo ?? "";
            emailAddress = user?.emailId ?? "";
            gender = user?.gender == "M" ? "Male" : "Female" ?? "";
          });
        }, onError: (error) {
          showSnackbar(context, "Something went wrong..");
        });
      });
    }
    // Default gender value
    prevName = name;
    prevMobileNumber = mobileNumber;
    prevEmailAddress = emailAddress;
    prevGender = gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 80.h),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        "$host/${widget.isDoctor ? doctor?.imageUrl : user?.imageUrl}"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            /*    ElevatedButton.icon(
              onPressed: () {
                // Add logic to edit profile photo here
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Photo'),
            ),*/
            SizedBox(
              height: 20,
            ),
            _buildEditableCard(
              context,
              'Name',
              name,
              (newValue) => setState(() => name = newValue),
            ),
            /* _buildEditableCard(
              context,
              'Last Name',
              lastName,
              (newValue) => setState(() => lastName = newValue),
            ),*/
            _buildEditableCard(
              context,
              'Mobile Number',
              mobileNumber,
              (newValue) => setState(() => mobileNumber = newValue),
            ),
            _buildEditableCard(
              context,
              'Email Address',
              emailAddress,
              (newValue) => setState(() => emailAddress = newValue),
            ),
            _buildEditableCard(
              context,
              'Gender',
              gender,
              (newValue) => setState(() => gender = newValue),
              isGenderField: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.isDoctor) {
                  Doctor doctor1 = Doctor(
                      doctorId: doctor?.doctorId,
                      doctorName: name,
                      phoneNo: mobileNumber,
                      emailId: emailAddress,
                      gender: gender.substring(0, 1));
                  _showSaveAllDialog(context, doctor: doctor1);
                } else {
                  User user1 = User(
                      userId: user?.userId,
                      userName: name,
                      phoneNo: mobileNumber,
                      emailId: emailAddress,
                      gender: gender.substring(0, 1));
                  _showSaveAllDialog(context, user: user1);
                }
              },
              child: Text('Save All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableCard(
    BuildContext context,
    String title,
    String subtitle,
    Function(String) onEdit, {
    bool isGenderField = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isGenderField) {
          _showGenderSelectionDialog(context, title);
        } else {
          _showEditDialog(context, title, subtitle, onEdit);
        }
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
          depth: 8,
          intensity: 0.7,
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
        child: ListTile(
          leading: Icon(
            leadingIcons[title] ?? Icons.person,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.edit),
        ),
      ),
    );
  }

  Future<void> _showEditDialog(
    BuildContext context,
    String title,
    String initialValue,
    Function(String) onSave,
  ) async {
    String editedValue = initialValue;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            decoration: InputDecoration(labelText: title),
            onChanged: (value) => editedValue = value,
            controller: TextEditingController(text: editedValue),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(editedValue);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showGenderSelectionDialog(
    BuildContext context,
    String title,
  ) async {
    final selectedGender = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Male'),
                onTap: () => Navigator.of(context).pop('Male'),
              ),
              ListTile(
                title: Text('Female'),
                onTap: () => Navigator.of(context).pop('Female'),
              ),
              ListTile(
                title: Text('Other'),
                onTap: () => Navigator.of(context).pop('Other'),
              ),
            ],
          ),
        );
      },
    );

    if (selectedGender != null) {
      setState(() => gender = selectedGender);
    }
  }

  Future<void> _showSaveAllDialog(BuildContext context,
      {User? user, Doctor? doctor}) async {
    // Create a dialog to choose between saving and canceling all changes
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Save All Changes?'),
          content: Text('Do you want to save all changes?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(true); // Save
                if (widget.isDoctor) {
                  apiService
                      .editDoctorProfile(
                          doctor?.doctorId ?? -1,
                          doctor?.doctorName ?? "",
                          doctor?.emailId ?? "",
                          doctor?.phoneNo ?? "",
                          doctor?.gender ?? "")
                      .then((value) {
                    if (value.error == 0) {
                      Preference.putDataString(
                          NAME_PREFERENCE, doctor?.doctorName ?? "");
                      Navigator.pop(context);
                    } else {
                      showSnackbar(context, "Something went wrong");
                    }
                  }, onError: (error) {
                    print(error);
                    showSnackbar(context, "Something went wrong");
                  });
                } else {
                  apiService
                      .editUserProfile(
                          user?.userId ?? -1,
                          user?.userName ?? "",
                          user?.emailId ?? "",
                          user?.phoneNo ?? "",
                          user?.gender ?? "")
                      .then((value) {
                    if (value.error == 0) {
                      Preference.putDataString(
                          NAME_PREFERENCE, user?.userName ?? "");
                      Navigator.pop(context);
                    } else {
                      showSnackbar(context, "Something went wrong");
                    }
                  }, onError: (error) {
                    print(error);
                    showSnackbar(context, "Something went wrong");
                  });
                }
              },
              child: Text('Save All'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (result != null && result) {
      // Save button was pressed, keep the changes
      prevName = name;
      prevMobileNumber = mobileNumber;
      prevEmailAddress = emailAddress;
      prevGender = gender;
      // Add your logic to save all changes here
    } else {
      // Cancel button was pressed, restore previous values
      setState(() {
        name = prevName;
        mobileNumber = prevMobileNumber;
        emailAddress = prevEmailAddress;
        gender = prevGender;
      });
    }
  }
}
