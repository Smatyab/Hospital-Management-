class AppoList {
  int? error;
  String? message;
  List<Appo>? data;

  AppoList({this.error, this.message, this.data});

  AppoList.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Appo>[];
      json['data'].forEach((v) {
        data!.add(new Appo.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'AppoList{error: $error, message: $message, data: $data}';
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

class Appo {
  int? appoId;
  int? userId;
  int? doctorId;
  int? paymentId;
  String? appoDt;
  String? appoTime;
  int? isHospitalVisit;
  int? isApprove;
  int? isActive;

  Appo(
      {this.appoId,
        this.userId,
        this.doctorId,
        this.paymentId,
        this.appoDt,
        this.appoTime,
        this.isHospitalVisit,
        this.isApprove,
        this.isActive});

  Appo.fromJson(Map<String, dynamic> json) {
    appoId = json['appo_id'];
    userId = json['user_id'];
    doctorId = json['doctor_id'];
    paymentId = json['payment_id'];
    appoDt = json['appo_dt'];
    appoTime = json['appo_time'];
    isHospitalVisit = json['is_hospital_visit'];
    isApprove = json['is_approve'];
    isActive = json['is_active'];
  }

  @override
  String toString() {
    return 'Appo{appoId: $appoId, userId: $userId, doctorId: $doctorId, paymentId: $paymentId, appoDt: $appoDt, appoTime: $appoTime, isHospitalVisit: $isHospitalVisit, isApprove: $isApprove, isActive: $isActive}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appo_id'] = this.appoId;
    data['user_id'] = this.userId;
    data['doctor_id'] = this.doctorId;
    data['payment_id'] = this.paymentId;
    data['appo_dt'] = this.appoDt;
    data['appo_time'] = this.appoTime;
    data['is_hospital_visit'] = this.isHospitalVisit;
    data['is_approve'] = this.isApprove;
    data['is_active'] = this.isActive;
    return data;
  }
}
