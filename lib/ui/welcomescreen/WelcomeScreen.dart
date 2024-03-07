import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hophseeflutter/ui/welcomescreen/PageConfig.dart';

import '../home/login_screen.dart';

class WelcomeCubit extends Cubit<int> {
  WelcomeCubit() : super(0);

  void nextPage() {
    emit(state + 1);
  }

  void previousPage() {
    emit(state - 1);
  }

  void goToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.route, (route) => false);
  }
}

class WelcomeScreen extends StatelessWidget {
  static const route = '/welcome_screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit(),
      child: WelcomeScreenContent(),
    );
  }
}

class WelcomeScreenContent extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  final List<PageConfig> pageConfigs = [
    PageConfig(
      imagePath: 'assets/welcome1.jpg',
      text:
          'Your Health, Our Priority:\nTrust in Excellence, Care with Compassion.',
      textStyle: GoogleFonts.lato(
        // Use the same font for consistency
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2, // Increase letter spacing
      ),
    ),
    PageConfig(
      imagePath: 'assets/welcome2.jpg',
      text: 'Book Appointments Easily',
      textStyle: GoogleFonts.lato(
        // Use the same font for consistency
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        wordSpacing: 2.0, // Increase word spacing
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final WelcomeCubit _welcomeCubit = BlocProvider.of<WelcomeCubit>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background White
          Container(
            color: Colors.white,
          ),
          // PageView for Welcome Screens
          BlocBuilder<WelcomeCubit, int>(
            builder: (context, state) {
              return PageView.builder(
                controller: _pageController,
                itemCount: pageConfigs.length,
                onPageChanged: (index) {
                  _welcomeCubit.emit(index);
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300.0, // Adjust the height as needed
                          decoration: BoxDecoration(
                            // Remove the gradient from the image
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Image.asset(
                            pageConfigs[index].imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          pageConfigs[index].text,
                          style: pageConfigs[index].textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          // "Back" Button
          Positioned(
            left: 20,
            bottom: 20,
            child: BlocBuilder<WelcomeCubit, int>(
              builder: (context, state) {
                return state > 0
                    ? IconButton(
                        onPressed: () {
                          _welcomeCubit.previousPage();
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                      )
                    : Container();
              },
            ),
          ),
          // "Skip" Button
          Positioned(
            right: 20,
            top: 20, // Adjusted to be at the top right corner
            child: TextButton(
              onPressed: () {
                _welcomeCubit.goToLogin(context);
              },
              child: Text(
                'Skip',
                style: GoogleFonts.lato(
                  // Use the same font for consistency
                  fontSize: 18,
                  color: Colors.black, // Change the text color
                ),
              ),
            ),
          ),
          // "Next" or "Get Started" Button
          Positioned(
            right: 20,
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {
                if (_welcomeCubit.state < pageConfigs.length - 1) {
                  _welcomeCubit.nextPage();
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  _welcomeCubit.goToLogin(context);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent.shade200,
                onPrimary: Color(0xFF00F260),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              ),
              child: BlocBuilder<WelcomeCubit, int>(
                builder: (context, state) {
                  return Text(
                    state < pageConfigs.length - 1 ? 'Next' : 'Get Started',
                    style: GoogleFonts.lato(
                      // Use the same font for consistency
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
