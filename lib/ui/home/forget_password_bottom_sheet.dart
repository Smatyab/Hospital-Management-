import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils.dart';

class ForgetPasswordBottomSheet extends StatefulWidget {
  @override
  _ForgetPasswordBottomSheetState createState() =>
      _ForgetPasswordBottomSheetState();
}

class _ForgetPasswordBottomSheetState extends State<ForgetPasswordBottomSheet> {
  PageController _pageController = PageController(initialPage: 0);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the keyboard when tapping outside the text field
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 120.h,
          bottom: 120.h,
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
              Colors.white60,
              Colors.blueGrey.shade400,
            ],
          ),
        ),
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
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white70,
                    Colors.blueGrey.shade100,
                    Colors.white70,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    EmailPage(
                      onNext: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      emailController: _emailController,
                    ),
                    /*OtpPage(
                      otpController: _otpController,
                      onNext: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      pageController: _pageController,
                      onResend: () {},
                    ),
                    ResetPasswordPage(
                      newPasswordController: _newPasswordController,
                      pageController: _pageController,
                    ),*/
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
    _pageController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
