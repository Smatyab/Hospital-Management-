import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/utils.dart';
import 'package:hophseeflutter/ui/payment/payment_bottom_sheet.dart';

import '../../data/module/payment_page_required.dart';

class PaymentDesign extends StatefulWidget {
  final PaymentPageRequired paymentPageRequired;
  const PaymentDesign({super.key, required this.paymentPageRequired});

  static const route = '/payment_screen';

  @override
  State<PaymentDesign> createState() => _PaymentDesignState();
}

class _PaymentDesignState extends State<PaymentDesign> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              backArrow(context),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.done,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 5) {
                            return 'Enter at least 5 characters';
                          }
                          return null;
                        },
                        controller: _amountController,
                        decoration: InputDecoration(
                          /*hintText: 'Amount',
                          labelText: 'Amount',*/
                          hintText: "500",
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 18.sp),
                          enabled: false,
                          prefixIcon: const Icon(
                            Icons.currency_rupee_sharp,
                            color: Colors.green,
                          ),
                          errorStyle: const TextStyle(fontSize: 14.0),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return PaymentBottomSheet(
                                  formKey: _formKey,
                                  cardNumberController: _cardNumberController,
                                  expiryDateController: _expiryDateController,
                                  cvvController: _cvvController,
                                  paymentPageRequired:
                                      widget.paymentPageRequired,
                                  amount:
                                      500 /*int.parse(_amountController.text)*/);
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'PAY NOW',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
