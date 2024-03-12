import 'package:flutter/material.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/ui/appointment/appo_book_screen.dart';
import 'package:hophseeflutter/ui/appointment/appointment_list_screen.dart';
import 'package:hophseeflutter/ui/dashboard/user_home_screen.dart';
import 'package:hophseeflutter/ui/doctordetails/doctor_details_sreen.dart';
import 'package:hophseeflutter/ui/doctordetails/doctor_list_screen.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_dashboard.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_home_screen.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_recent_visit.dart';
import 'package:hophseeflutter/ui/doctorpannel/patient_profile_page.dart';
import 'package:hophseeflutter/ui/home/login_screen.dart';
import 'package:hophseeflutter/ui/home/register_screen.dart';
import 'package:hophseeflutter/ui/payment/payment_design.dart';
import 'package:hophseeflutter/ui/payment/payment_done.dart';
import 'package:hophseeflutter/ui/profile/edit_profile_screen.dart';
import 'package:hophseeflutter/ui/profile/help_design.dart';
import 'package:hophseeflutter/ui/profile/profile_design.dart';
import 'package:hophseeflutter/ui/profile/setting.dart';
import 'package:hophseeflutter/ui/splash/splash_screen.dart';
import 'package:hophseeflutter/ui/welcomescreen/WelcomeScreen.dart';

import 'data/module/payment_page_required.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Get the arguments passed when navigating to a screen.
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case LoginScreen.route:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RegisterScreen.route:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case UserHomeScreen.route:
        return MaterialPageRoute(builder: (_) => const UserHomeScreen());

      case DoctorDashboardScreen.route:
        return MaterialPageRoute(builder: (_) => DoctorDashboardScreen());

      case DoctorRecentVisitScreen.route:
        return MaterialPageRoute(builder: (_) => DoctorRecentVisitScreen());

      case ProfileDesign.route:
        return MaterialPageRoute(builder: (_) => const ProfileDesign());

      case PatientInfoPage.route:
        return MaterialPageRoute(
            builder: (_) => PatientInfoPage(patientId: args as int));

      case DoctorHomeScreen.route:
        return MaterialPageRoute(builder: (_) => const DoctorHomeScreen());

      case WelcomeScreen.route:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());

      case PaymentDesign.route:
        return MaterialPageRoute(
            builder: (_) => PaymentDesign(
                paymentPageRequired: args as PaymentPageRequired));

      case PaymentDoneDesign.route:
        return MaterialPageRoute(
            builder: (_) => PaymentDoneDesign(
                  amount: args as int,
                ));

      case SettingsPage.route:
        return MaterialPageRoute(builder: (_) => SettingsPage());

      case HelpMePage.route:
        return MaterialPageRoute(builder: (_) => HelpMePage());

      case EditProfileScreen.route:
        return MaterialPageRoute(
            builder: (_) => EditProfileScreen(isDoctor: args as bool));

      case AppointmentListScreen.route:
        return MaterialPageRoute(builder: (_) => AppointmentListScreen());

      case DoctorListScreen.route:
        return MaterialPageRoute(
            builder: (_) => DoctorListScreen(
                  doctorList: args as DoctorList,
                ));

      case AppointmentBookScreen2.route:
        return MaterialPageRoute(
            builder: (_) => AppointmentBookScreen2(
                  doctor: args as Doctor,
                ));

      case DoctorDetailScreen.route:
        return MaterialPageRoute(
            builder: (_) => DoctorDetailScreen(
                  doctor: args as Doctor,
                ));

      default:
        // If the route name is not recognized, you can handle it here.
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: const Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
