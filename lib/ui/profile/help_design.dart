import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpMePage extends StatelessWidget {
  static const route = '/help_me_screen';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));

    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 40.h),
              decoration: BoxDecoration(
                color: Color(0xFF3AA7FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.w),
                  bottomRight: Radius.circular(40.w),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.help_outline_outlined,
                    size: 120.sp,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Need Help?',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Our support team is here to assist you. Feel free to ask any questions!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.w)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  FaqItem(
                    question: 'How do I book an appointment?',
                    answer:
                        'To book an appointment, go to the Home screen and tap on "Book Appointment." Select the doctor, choose a date and time, and confirm your booking.',
                  ),
                  FaqItem(
                    question: 'How do I cancel an appointment?',
                    answer:
                        'To cancel an appointment, go to the My Appointments screen, find the appointment you want to cancel, and tap on "Cancel Appointment."',
                  ),
                  FaqItem(
                    question: 'How do I contact customer support?',
                    answer:
                        'You can contact our customer support team by tapping on the "Contact Support" button on the Profile screen. We are here to help you!',
                  ),
                  FaqItem(
                    question: 'Is there a chat support available?',
                    answer:
                        'Yes, we provide chat support. You can initiate a chat with our support team by tapping on the chat icon in the app.',
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      // Show contact us bottom sheet
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ContactUsBottomSheet();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF3AA7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 32.w),
                    ),
                    child: Text(
                      'Contact Support',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.w,
            blurRadius: 5.w,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            answer,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactUsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2.5.w),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.email, size: 24.sp),
            title: Text(
              'Email us',
              style: TextStyle(fontSize: 18.sp),
            ),
            onTap: () {
              // Implement email functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.phone, size: 24.sp),
            title: Text(
              'Call us',
              style: TextStyle(fontSize: 18.sp),
            ),
            onTap: () {
              // Implement call functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.chat, size: 24.sp),
            title: Text(
              'Chat with us',
              style: TextStyle(fontSize: 18.sp),
            ),
            onTap: () {
              // Implement chat functionality
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
