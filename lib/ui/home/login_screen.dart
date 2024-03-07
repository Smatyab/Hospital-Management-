import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hophseeflutter/core/extfunction.dart';
import 'package:hophseeflutter/ui/home/register_screen.dart';
import '../../core/utils.dart';
import '../../core/widget/custom_text_field.dart';
import '../../core/widget/common_label_with_tap.dart';
import '../../data/datasource/api_services.dart';
import 'forget_password_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isDoctor = false; // Track whether the user is a Doctor
  ApiServiceImpl apiService = ApiServiceImpl(Dio());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: true);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 120.h,
          bottom: 75.h,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              /*Color(0xFF74ebd5),
              Color(0xFFACB6E5),*/
              Colors.blueGrey.shade400,
              Colors.white60,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(25),
                ),
                depth: 8,
                lightSource: LightSource.topLeft,
                color: Colors.transparent,
                intensity: 0.7,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 150.w,
                          height: 150.h,
                          child: Image.asset('assets/applogo.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // UserName field
                    TextFieldDesign(
                      hintText: 'Enter your email',
                      labelText: 'Enter your email',
                      controller: emailIdController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.isValidEmail) {
                          return 'Enter with valid email';
                        }
                        return null; // Return null if the input is valid
                      },
                      prefixIcon: const Icon(
                        Icons.person_2_rounded,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Password field
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
                        Icons.lock,
                        color: Colors.black87,
                      ),
                    ),

                    // Checkbox for Doctor login
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: isDoctor,
                                onChanged: (value) {
                                  setState(() {
                                    isDoctor = value!;
                                  });
                                },
                              ),
                              const Text('Login as Doctor'),
                            ],
                          ),
                          Row(children: [
                            CommonLabelWithTap(
                              text: 'ForgotPassword?',
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      ForgetPasswordBottomSheet(),
                                  isScrollControlled: true,
                                );
                              },
                            )
                          ]),
                        ],
                      ),
                    ),
                    // Login Button
                    Center(
                      child: NeumorphicButton(
                        onPressed: () {
                          hideKeyboard(context);
                          var email = emailIdController.text;
                          var password = passwordController.text;
                          if (_formKey.currentState!.validate()) {
                            if (isDoctor) {
                              doctorLogin(apiService, context, email, password);
                            } else {
                              loginUser(apiService, context, email, password);
                            }
                          }
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(25)),
                          intensity: 0.7,
                          color: Colors.lightBlueAccent.shade200,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.h,
                            horizontal: 30.w,
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.caladea(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                        ),
                        child: Text("Doesn't Have An Account ?"),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      CommonLabelWithTap(
                        text: 'Sign Up',
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen.route);
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
