import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/extfunction.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          //color: HexColor.fromHex("#B9C4C6CC"),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.white70.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 16, top: 5, bottom: 5),
              child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 4,
                  intensity: 0.5,
                  lightSource: LightSource.topLeft,
                ),
                child: Container(
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/doctor.png')),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'name',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          '5',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Icon(
                                size: 20,
                                Icons.star,
                                color: HexColor.fromHex("FFD205"),
                              ),
                              Icon(
                                size: 20,
                                Icons.star,
                                color: HexColor.fromHex("FFD205"),
                              ),
                              Icon(
                                size: 20,
                                Icons.star,
                                color: HexColor.fromHex("FFD205"),
                              ),
                              Icon(
                                size: 20,
                                Icons.star,
                                color: HexColor.fromHex("FFD205"),
                              ),
                              Icon(
                                size: 20,
                                Icons.star,
                                color: HexColor.fromHex("FFD205"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Committed to Care, Available for You: Healing Lives,One Appointment at a Time.',
                      style: GoogleFonts.abel(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

/*
class DoctorCard2 extends StatelessWidget {
  DoctorCard2({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: HexColor.fromHex("#B9C4C6CC"),
          //borderRadius: BorderRadius.circular(12),
          borderRadius: BorderRadius.circular(55),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 16, top: 5, bottom: 5),
              child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 4,
                  intensity: 0.5,
                  lightSource: LightSource.topLeft,
                ),
                child: Container(
                    height: 120,
                    width: 100,
                    child: Image.asset('assets/doctor.png')),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Degree : ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
*/
