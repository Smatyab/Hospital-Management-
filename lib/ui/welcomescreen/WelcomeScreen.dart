import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hophseeflutter/ui/welcomescreen/PageConfig.dart';

import '../home/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const route = '/welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<PageConfig> pageConfigs = [
    PageConfig(
      imagePath: 'assets/applogo2.png',
      text: 'Welcome to HoPhSee',
      textStyle: GoogleFonts.lato(
        // Use a different font (Lato)
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic, // Add italic style
      ),
    ),
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
    return Scaffold(
      body: Stack(
        children: [
          // Background White
          Container(
            color: Colors.white,
          ),
          // PageView for Welcome Screens
          PageView.builder(
            controller: _pageController,
            itemCount: pageConfigs.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
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
                        image: DecorationImage(
                          image: AssetImage(pageConfigs[index].imagePath),
                          fit: BoxFit.cover,
                        ),
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
          ),
          // "Back" Button
          Positioned(
            left: 20,
            bottom: 20,
            child: _currentPage > 0
                ? IconButton(
                    onPressed: () {
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
                : Container(),
          ),
          // "Skip" Button
          Positioned(
            right: 20,
            top: 20, // Adjusted to be at the top right corner
            child: TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.route, (route) => false);
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
                if (_currentPage < pageConfigs.length - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Handle the last page action
                  // For now, let's navigate to another page as an example
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.route, (route) => false);
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
              child: Text(
                _currentPage < pageConfigs.length - 1 ? 'Next' : 'Get Started',
                style: GoogleFonts.lato(
                  // Use the same font for consistency
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
