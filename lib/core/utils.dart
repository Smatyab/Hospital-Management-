import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hophseeflutter/core/share_preference.dart';
import 'package:hophseeflutter/data/datasource/api_services.dart';
import 'package:hophseeflutter/data/module/categories.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../ui/dashboard/user_home_screen.dart';
import '../ui/doctorpannel/doctor_home_screen.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void hideSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}

void loginUser(ApiServiceImpl apiService, BuildContext context, String email,
    String password) {
  apiService.loginUser(email, password).then((value) {
    if (value.error == 0) {
      if (value.data?.userId != null) {
        var user = value.data;
        Preference.putDataUserDetails(
            user?.userName, user?.imageUrl, user?.userId);
        Navigator.pushNamedAndRemoveUntil(
            context, UserHomeScreen.route, (route) => false);
      } else {
        showSnackbar(context, "Something went wrong try again");
      }
    } else {
      showSnackbar(context, "invalid email or password");
    }
  }, onError: (error) {
    showSnackbar(context, "Something went wrong try again");
  });
}

void doctorLogin(ApiServiceImpl apiService, BuildContext context, String email,
    String password) {
  apiService.loginDoctor(email, password).then((value) {
    print("object ${value.toString()}");
    if (value.error == 0) {
      if (value.data?.doctorId != null) {
        var doctor = value.data;
        Preference.putDataUserDetails(
            doctor?.doctorName, doctor?.imageUrl, doctor?.doctorId,
            isDoctor: true);

        Navigator.pushNamedAndRemoveUntil(
          context,
          DoctorHomeScreen.route,
          (route) => false,
        );
      } else {
        showSnackbar(context, "${value.message}");
      }
    } else {
      showSnackbar(context, "invalid email or password");
    }
  }, onError: (error) {
    showSnackbar(context, "invalid email or password");
  });
}

List<Categories> getDoctorCategories() {
  List<Categories> categories = [
    Categories(
      Text: 'Dentists',
      color: Colors.blueGrey.shade100,
    ),
    Categories(
      Text: 'Psychiatrists',
      color: Colors.blueGrey.shade100,
    ),
    Categories(
      Text: 'Surgeons',
      color: Colors.blueGrey.shade100,
    ),
    Categories(
      Text: 'Anesthesiologists',
      color: Colors.blueGrey.shade100,
    ),
    Categories(
      Text: 'Oncologists',
      color: Colors.blueGrey.shade100,
    ),
  ];
  return categories;
}

void hideKeyboard(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

Future<void> delay(int second) async {
  await Future.delayed(Duration(seconds: second));
  // Your code to be executed after the delay goes here
}

Widget backArrow(BuildContext context) {
  return Container(
    height: 40.h,
    width: double.infinity,
    padding: EdgeInsets.only(left: 10.w, right: 10.w),
    child: Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        child: const Icon(Icons.arrow_back_outlined),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}

String convertIsoToIndianDate(String isoDate) {
  try {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat(
        'yyyy-MM-dd', 'en_IN'); // 'en_IN' is the locale for Indian English

    final date = inputFormat.parse(isoDate);
    final indianDate = date.add(Duration(days: 1)); // Subtract one day

    return outputFormat.format(indianDate);
  } catch (e) {
    print('Error converting date: $e');
    return '';
  }
}

String convertToyyyymmdd(String inputDate) {
  // Split the input date string into day, month, and year parts
  List<String> dateParts = inputDate.split('/');

  if (dateParts.length == 3) {
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    // Create a DateTime object with the parsed values
    DateTime dateTime = DateTime(year, month, day);

    // Format the DateTime as a string in yyyy/mm/dd format
    String formattedDate =
        "${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}";

    print(formattedDate);
    return formattedDate;
  }
  return "";
}

String getENDate(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate);

  // Format the date in Indian yyyy-MM-dd format
  String indianDateFormat = DateFormat('yyyy-MM-dd', 'en_IN').format(dateTime);

  return indianDateFormat;
}

class EmailPage extends StatelessWidget {
  final VoidCallback onNext;
  final TextEditingController emailController;

  const EmailPage({
    Key? key,
    required this.onNext,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 4,
              intensity: 0.5,
              lightSource: LightSource.topLeft,
            ),
            child: Container(
              height: 100.h,
              width: 100.w,
              color: Colors.white,
              child: Icon(
                size: 50.sp,
                Icons.lock_person_outlined,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Please enter your email address. You will receive a link to create a new password via email.',
            textAlign: TextAlign.center,
            style: GoogleFonts.abel(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 4,
              intensity: 0.5,
              lightSource: LightSource.topLeft,
            ),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.blue),
                hintText: 'Enter your email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeumorphicButton(
                onPressed: onNext,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 4,
                  intensity: 0.5,
                  lightSource: LightSource.topLeft,
                  color: Colors.blue,
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*class OtpPage extends StatelessWidget {
  final TextEditingController otpController;
  final VoidCallback onNext;
  final VoidCallback onResend;
  final PageController pageController;

  const OtpPage({
    Key? key,
    required this.otpController,
    required this.onNext,
    required this.onResend,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 4,
              intensity: 0.5,
              lightSource: LightSource.topLeft,
            ),
            child: Container(
              height: 100.h,
              width: 100.w,
              color: Colors.white,
              child: Icon(
                size: 50.sp,
                Icons.security,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'We have sent you a code to your email',
            textAlign: TextAlign.center,
            style: GoogleFonts.abel(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 4,
              intensity: 0.5,
              lightSource: LightSource.topLeft,
            ),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Resend OTP Button
              TextButton(
                onPressed: onResend,
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.blue,
                  ),
                  NeumorphicButton(
                    onPressed: onNext,
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 4,
                      intensity: 0.5,
                      lightSource: LightSource.topLeft,
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController newPasswordController;
  final PageController pageController;

  const ResetPasswordPage({
    Key? key,
    required this.newPasswordController,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 4,
              intensity: 0.5,
              lightSource: LightSource.topLeft,
            ),
            child: Container(
              height: 100.h,
              width: 100.w,
              color: Colors.white,
              child: Icon(
                size: 50.sp,
                Icons.lock_reset_sharp,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Enter new password and confirm it.',
            textAlign: TextAlign.center,
            style: GoogleFonts.abel(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 4,
              intensity: 0.5,
              lightSource: LightSource.topLeft,
            ),
            child: TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter New Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 4,
              intensity: 0.5,
              lightSource: LightSource.topLeft,
            ),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm New Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              NeumorphicButton(
                onPressed: () {
                  print('New Password: ${newPasswordController.text}');
                  Navigator.of(context).pop();
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 4,
                  intensity: 0.5,
                  lightSource: LightSource.topLeft,
                  color: Colors.blue,
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/

Future<String> initiatePayment(double amount, Razorpay razorpay) async {
  Map<String, dynamic> options = {
    'key': 'rzp_test_v9RHzydMvghKWL', // Replace with your API key
    'amount': amount * 100, // Convert amount to paise (100 paise = ₹1)
    'name': 'Hophsee',
    'description': 'Payment for booking appointment',
    'external': {
      'wallets': [
        'paytm'
      ] // Optional: List of wallets to display (e.g., 'paytm')
    }
  };

  try {
    razorpay.open(options);
    return "Successfully";
  } catch (e) {
    debugPrint('Error: $e'); // Log payment errors for debugging
    // Handle errors appropriately, e.g., show an error message to the user
    return "Unsuccessfully";
  }
  return "Unsuccessfully";
}
