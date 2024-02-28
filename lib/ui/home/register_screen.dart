import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/extfunction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/utils.dart';
import '../../core/widget/custom_text_field.dart';
import '../../core/widget/date_picker.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/user_model.dart';
import 'gender_drop_down.dart';
import '../home/login_screen.dart'; // Import the login screen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  static const route = '/register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  String selectedGender = 'Male';
  File? imageFile; // Initialize imageFile as nullable
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();

  void handleGenderChange(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              /*Color(0xFF74ebd5),
              Color(0xFFACB6E5),*/
              Colors.lightBlueAccent.shade400,
              Colors.white60,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 75),
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12),
                ),
                depth: 8,
                lightSource: LightSource.topLeft,
                color: Colors.transparent,
                intensity: 0.7,
              ),
              child: Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ProfileImagePicker(),
                    const SizedBox(height: 20),
                    TextFieldDesign(
                      hintText: 'Full Name',
                      labelText: 'Full Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full Name';
                        }
                        return null; // Return null if the input is valid
                      },
                      controller: firstNameController,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFieldDesign(
                      hintText: 'Email',
                      labelText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.isValidEmail) {
                          return 'Enter with valid email';
                        }
                        return null; // Return null if the input is valid
                      },
                      controller: emailController,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFieldDesign(
                      hintText: 'Mobile Number',
                      labelText: 'Mobile Number',
                      controller: mobileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null; // Return null if the input is valid
                      },
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomDatePicker(
                      onClick: () {
                        hideKeyboard(context);
                        pickDateDialog();
                      },
                      selectedDate: _selectedDate,
                      onDateSelected:
                          (DateTime) {}, // Pass the selected date here
                    ),
                    const SizedBox(height: 5),
                    TextFieldDesign(
                      hintText: 'Password',
                      labelText: 'Password',
                      isObscure: true,
                      showPasswordIcon: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null; // Return null if the input is valid
                      },
                      controller: passwordController,
                      prefixIcon: const Icon(
                        Icons.password_sharp,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GenderDropdownTextField(),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: NeumorphicButton(
                        onPressed: () {
                          if (imageFile == null) {
                            showSnackbar(context, "Select Your Profile Image");
                            return;
                          }
                          var userName = firstNameController.text;
                          var email = emailController.text;
                          var mobile = mobileController.text;
                          var password = passwordController.text;
                          var gender = selectedGender;
                          var dateOfBirth =
                              DateFormat("yyyy-MM-dd").format(_selectedDate);
                          var user = User(
                            userName: userName,
                            emailId: email,
                            phoneNo: mobile,
                            password: password,
                            gender: gender.substring(0, 1),
                            dateOfBirth: dateOfBirth,
                          );
                          print("user : ${user.toJson()}");
                          apiService.registerUser(user, imageFile!).then(
                            (value) {
                              if (value.error == 0) {
                                // Successfully registered, navigate to login screen
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginScreen.route,
                                );
                              } else {
                                showSnackbar(context, "Something went wrong");
                              }
                            },
                            onError: (error) {
                              print(error);
                              showSnackbar(context, "Something went wrong");
                            },
                          );
                        },
                        style: NeumorphicStyle(
                          color: Colors.lightBlueAccent.shade200,
                          shape: NeumorphicShape.convex,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(25),
                          ),
                          depth: 8,
                          intensity: 0.7,
                          //color: Colors.blueAccent[200],
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.h,
                            horizontal: 30.w,
                          ),
                          child: Text(
                            'Register',
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ProfileImagePicker() {
    return GestureDetector(
      onTap: _getImageFromUser,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            children: [
              ClipOval(
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/placeholder.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 24,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickDateDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Future<void> _getImageFromUser() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    } else {
      // User canceled the image selection.
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
