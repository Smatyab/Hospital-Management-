import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_dashboard.dart';
import 'package:hophseeflutter/ui/doctorpannel/doctor_recent_visit.dart';

import '../profile/profile_design.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);
  static const route = '/doctor_home_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<DoctorHomeScreen> {

  final List<Widget> screens = [
    DoctorDashboardScreen(),
    DoctorRecentVisitScreen(),
    const ProfileDesign(isNotBackArrow: false),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: -8,
            intensity: 0.7,
            color: Colors.transparent,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          child: screens[selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.white]),
        ),
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: 8,
            intensity: 0.7,
            color: Colors.transparent,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(24),
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                screens.length,
                (index) => NeumorphicButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12),
                    ),
                    depth: 4,
                    intensity: 0.5,
                    lightSource: LightSource.topLeft,
                    color: selectedIndex == index
                        ? Colors.lightBlueAccent.shade400
                        : Colors.transparent,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    index == 0
                        ? Icons.home_outlined
                        : index == 1
                            ? Icons.list_alt
                            : Icons.person_outline,
                    size: 24,
                    color: selectedIndex == index
                        ? Colors.white
                        : Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
