import 'package:dio/dio.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hophseeflutter/data/module/payment_page_required.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../core/utils.dart';
import '../../core/widget/custome_app_bar.dart';
import '../../data/datasource/api_services.dart';
import '../../data/module/doctor_model.dart';
import '../dashboard/doctor_card.dart';
import '../dashboard/user_home_screen.dart';

class AppointmentBookScreen2 extends StatefulWidget {
  final Doctor doctor;

  const AppointmentBookScreen2({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  static const route = '/appointment2';

  @override
  State<AppointmentBookScreen2> createState() => _AppointmentBookScreen2State();
}

class _AppointmentBookScreen2State extends State<AppointmentBookScreen2> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime = TimeOfDay.now();
  TextEditingController dateTimeController = TextEditingController();
  var razorpay = Razorpay();
  ApiServiceImpl apiService = ApiServiceImpl(Dio());

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(Duration(days: 30)),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        // Normalize the selected time to handle cases where minutes exceed 60
        pickedTime = normalizeTime(pickedTime);

        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Check if the selected time is in the future and within the allowed time range
        if (selectedDateTime.isAfter(currentDate) &&
            (pickedTime.minute % 30 == 0 || pickedTime.minute == 0)) {
          setState(() {
            selectedDate = pickedDate;
            selectedTime = pickedTime!;
            dateTimeController.text =
                '${DateFormat('dd-MM-yyyy').format(selectedDate!)} ${selectedTime!.format(context)}';
          });
        } else {
          // Show an error message or handle the invalid time selection
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Invalid Time Selection'),
                content: Text(
                    'Please select a valid time in the future with 30-minute intervals starting from 00:00.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  TimeOfDay normalizeTime(TimeOfDay time) {
    // Normalize the time to handle cases where minutes exceed 60
    int totalMinutes = time.hour * 60 + time.minute;
    int normalizedMinutes = totalMinutes % 1440; // 1440 minutes in a day
    return TimeOfDay(
        hour: normalizedMinutes ~/ 60, minute: normalizedMinutes % 60);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomAppbar2(
                        backBtn: false, label: 'Book your Appointment'),
                    Divider(),
                    DoctorCard(
                      name: widget.doctor.doctorName ?? "",
                      description: widget.doctor.briefDesc ?? "",
                      imagePath: widget.doctor.imageUrl ?? "",
                      AppoButton: false,
                      DetailButton: false,
                      exp: '',
                      degree: '',
                      onTapDetails: () {},
                      onTapAppo: () {},
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Date & Time',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          DateTimePicker(),
                          SizedBox(height: 10.h),
                          AppointmentDetailRow(
                            label: 'Consulting Type',
                            value: 'Special',
                          ),
                          AppointmentDetailRow(
                            label: 'Duration',
                            value: '30 Minutes',
                          ),
                          AppointmentDetailRow(
                            label: 'Patient Name',
                            value: 'Kaushik Variya',
                          ),
                          Divider(),
                          AppointmentDetailRow(
                            label: 'Amount',
                            value: 'Rs. 500',
                          ),
                          AppointmentDetailRow(
                            label: 'Duration (30 Minutes)',
                            value: '2 X Rs.500',
                          ),
                          AppointmentDetailRow(
                            label: 'File Charge',
                            value: 'Rs.100',
                          ),
                          Divider(),
                          AppointmentDetailRow(
                            label: 'Total Amount',
                            value: 'Rs. 1100',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: NeumorphicButton(
                    onPressed: selectedDate != null && selectedTime != null
                        ? () {
                            initiatePayment(500, razorpay);
                            print("Pay now Button click");
                            showSnackbar(context, "Waiting for payment portal");
                            /*  // Format the time
                            Navigator.pushNamed(context, PaymentDesign.route,
                                arguments: PaymentPageRequired(
                                    doctorId: doctorId,
                                    appoDt: appoDt,
                                    appoTime: appoTime));*/
                          }
                        : null, // Disable the button if date or time is not selected
                    style: selectedDate != null && selectedTime != null
                        ? NeumorphicStyle(
                            color: Colors.lightBlueAccent.shade200,
                            shape: NeumorphicShape.convex,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(25),
                            ),
                            depth: 8,
                            intensity: 0.7,
                          )
                        : NeumorphicStyle(
                            color: Colors
                                .grey.shade400, // Change the color to grey
                            shape: NeumorphicShape.convex,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(25),
                            ),
                            depth: 8,
                            intensity: 0.7,
                          ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 20.w),
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    print("payment pay");
    showSnackbar(context, "Payment done please wait few second...");
    int? doctorId = widget.doctor.doctorId;
    String appoDt =
        DateFormat('yyyy-MM-dd').format(selectedDate!); // Format the date
    String appoTime = selectedTime!.format(context);
    PaymentPageRequired paymentPageRequired = PaymentPageRequired(
        doctorId: doctorId, appoDt: appoDt, appoTime: appoTime);
    apiService
        .addPaymentDetails(paymentPageRequired, "${response.paymentId}", 500)
        .then((value) {
      if (value.error == 0) {
        int? paymentId = value.data?.insertId;
        if (paymentId != null) {
          apiService
              .addAppointment(paymentPageRequired, paymentId)
              .then((value) {
            if (value.error == 0) {
              showSnackbar(context, "Something went wrong..");
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, UserHomeScreen.route, (route) => false);
              /*Navigator.pushNamed(
                  context, PaymentDoneDesign.route,
                  arguments: amount);*/
            }
          });
        } else {
          showSnackbar(context, "Something went wrong..");
        }
      } else {
        showSnackbar(context, "Something went wrong..");
      }
    });
    // Handle successful payment, e.g., show a success message
    // Use response.paymentId and other data as needed
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print("payment pay error");
    showSnackbar(context, "Something went wrong..");
    // Handle payment failure, e.g., show an error message
    // Use response.code and response.message for error details
  }

  Widget DateTimePicker() {
    return TextFormField(
      readOnly: true,
      controller: dateTimeController,
      onTap: () => _selectDateTime(context),
      decoration: InputDecoration(
        hintText: 'Select Date & Time',
        border: InputBorder.none,
        suffixIcon: IconButton(
          onPressed: () => _selectDateTime(context),
          icon: Icon(Icons.event),
        ),
      ),
    );
  }
}

class AppointmentDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const AppointmentDetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.adamina(
            fontSize: 15.sp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
