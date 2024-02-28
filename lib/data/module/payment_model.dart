class PaymentList {
  int? error;
  String? message;
  List<Payment>? data;

  PaymentList({this.error, this.message, this.data});

  PaymentList.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Payment>[];
      json['data'].forEach((v) {
        data!.add(new Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payment {
  int? paymentId;
  String? paymentRefNo;
  String? payerId;
  String? payeeId;
  String? payerType;
  String? payeeType;
  int? paymentAmmount;
  String? paymentDt;

  Payment(
      {this.paymentId,
        this.paymentRefNo,
        this.payerId,
        this.payeeId,
        this.payerType,
        this.payeeType,
        this.paymentAmmount,
        this.paymentDt});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    paymentRefNo = json['payment_ref_no'];
    payerId = json['payer_id'];
    payeeId = json['payee_id'];
    payerType = json['payer_type'];
    payeeType = json['payee_type'];
    paymentAmmount = json['payment_ammount'];
    paymentDt = json['payment_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_id'] = this.paymentId;
    data['payment_ref_no'] = this.paymentRefNo;
    data['payer_id'] = this.payerId;
    data['payee_id'] = this.payeeId;
    data['payer_type'] = this.payerType;
    data['payee_type'] = this.payeeType;
    data['payment_ammount'] = this.paymentAmmount;
    data['payment_dt'] = this.paymentDt;
    return data;
  }
}