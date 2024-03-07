class DoctorList {
  int? error;
  String? message;
  List<Doctor>? data;

  DoctorList({this.error, this.message, this.data});

  DoctorList.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Doctor>[];
      json['data'].forEach((v) {
        data!.add(Doctor.fromJson(v));
      });
    }
  }


  @override
  String toString() {
    return 'DoctorList{error: $error, message: $message, data: $data}';
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

class Doctor {
  int? doctorId;
  String? doctorName;
  String? emailId;
  String? phoneNo;
  String? password;
  String? gender;
  String? dateOfBirth;
  String? imageUrl;
  String? speciality;
  String? briefDesc;
  String? doctorCertiNo;
  String? doctorCertiImageUrl;
  String? doctorTimeFrom;
  String? doctorTimeTo;
  int? salaryAmount;
  String? lastLogin;
  String? createDt;
  String? updateDt;
  int? isActive;

  Doctor(
      {this.doctorId,
        this.doctorName,
        this.emailId,
        this.phoneNo,
        this.password,
        this.gender,
        this.dateOfBirth,
        this.imageUrl,
        this.speciality,
        this.briefDesc,
        this.doctorCertiNo,
        this.doctorCertiImageUrl,
        this.doctorTimeFrom,
        this.doctorTimeTo,
        this.salaryAmount,
        this.lastLogin,
        this.createDt,
        this.updateDt,
        this.isActive});

  Doctor.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    emailId = json['email_id'];
    phoneNo = json['phone_no'];
    password = json['password'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    imageUrl = json['image_url'];
    speciality = json['speciality'];
    briefDesc = json['brief_desc'];
    doctorCertiNo = json['doctor_certi_no'];
    doctorCertiImageUrl = json['doctor_certi_image_url'];
    doctorTimeFrom = json['doctor_time_from'];
    doctorTimeTo = json['doctor_time_to'];
    salaryAmount = json['salary_amount'];
    lastLogin = json['last_login'];
    createDt = json['create_dt'];
    updateDt = json['update_dt'];
    isActive = json['is_active'];
  }


  @override
  String toString() {
    return 'Doctor{doctorId: $doctorId, doctorName: $doctorName, emailId: $emailId, phoneNo: $phoneNo, password: $password, gender: $gender, dateOfBirth: $dateOfBirth, imageUrl: $imageUrl, speciality: $speciality, briefDesc: $briefDesc, doctorCertiNo: $doctorCertiNo, doctorCertiImageUrl: $doctorCertiImageUrl, doctorTimeFrom: $doctorTimeFrom, doctorTimeTo: $doctorTimeTo, salaryAmount: $salaryAmount, lastLogin: $lastLogin, createDt: $createDt, updateDt: $updateDt, isActive: $isActive}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['doctor_name'] = this.doctorName;
    data['email_id'] = this.emailId;
    data['phone_no'] = this.phoneNo;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['image_url'] = this.imageUrl;
    data['speciality'] = this.speciality;
    data['brief_desc'] = this.briefDesc;
    data['doctor_certi_no'] = this.doctorCertiNo;
    data['doctor_certi_image_url'] = this.doctorCertiImageUrl;
    data['doctor_time_from'] = this.doctorTimeFrom;
    data['doctor_time_to'] = this.doctorTimeTo;
    data['salary_amount'] = this.salaryAmount;
    data['last_login'] = this.lastLogin;
    data['create_dt'] = this.createDt;
    data['update_dt'] = this.updateDt;
    data['is_active'] = this.isActive;
    return data;
  }
}