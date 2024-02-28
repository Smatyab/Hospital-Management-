import 'package:flutter/material.dart';

import '../dashboard/user_home_screen.dart';

class PaymentDoneDesign extends StatefulWidget {
  const PaymentDoneDesign({super.key, required this.amount});

  static const route = '/payment_done_screen';
  final int amount;

  @override
  State<PaymentDoneDesign> createState() => _PaymentDoneDesignState();
}

class _PaymentDoneDesignState extends State<PaymentDoneDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top:
                MediaQuery.of(context).size.height * 0.05, // Adjust top padding
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft, // Align to the top-left corner
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, UserHomeScreen.route, (route) => false);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height *
                        0.1, // Adjust top padding
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width *
                            0.4, // Adjust size based on screen width
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Container(
                          height: MediaQuery.of(context).size.width *
                              0.07, // Adjust size based on screen width
                          width: MediaQuery.of(context).size.width * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width *
                                    0.5), // Adjust size based on screen width
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.done,
                            size: 120,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width *
                              0.4, // Adjust size based on screen width
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(MediaQuery.of(
                                          context)
                                      .size
                                      .width *
                                  0.04), // Adjust size based on screen width
                              color: Colors.greenAccent,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.02, // Adjust left padding based on screen width
                                ),
                                child:  Row(
                                  children: [
                                    const Icon(
                                      Icons.currency_rupee_sharp,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      widget.amount.toString(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
