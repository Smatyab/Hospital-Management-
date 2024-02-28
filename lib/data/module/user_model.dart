class UserModel {
  int? error;
  String? message;
  List<User>? data;

  UserModel({this.error, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(new User.fromJson(v));
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

class User {
  int? userId;
  String? userName;
  String? emailId;
  String? phoneNo;
  String? password;
  String? gender;
  String? dateOfBirth;
  String? imageUrl;
  String? doctorCertiNo;
  String? doctorCertiImageUrl;
  String? lastLogin;
  String? createDt;
  String? updateDt;
  int? isDoctor;
  int? isActive;

  User(
      {this.userId,
        this.userName,
        this.emailId,
        this.phoneNo,
        this.password,
        this.gender,
        this.dateOfBirth,
        this.imageUrl,
        this.doctorCertiNo,
        this.doctorCertiImageUrl,
        this.lastLogin,
        this.createDt,
        this.updateDt,
        this.isDoctor,
        this.isActive});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    emailId = json['email_id'];
    phoneNo = json['phone_no'];
    password = json['password'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    imageUrl = json['image_url'];
    doctorCertiNo = json['doctor_certi_no'];
    doctorCertiImageUrl = json['doctor_certi_image_url'];
    lastLogin = json['last_login'];
    createDt = json['create_dt'];
    updateDt = json['update_dt'];
    isDoctor = json['is_doctor'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['email_id'] = this.emailId;
    data['phone_no'] = this.phoneNo;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['image_url'] = this.imageUrl;
    data['doctor_certi_no'] = this.doctorCertiNo;
    data['doctor_certi_image_url'] = this.doctorCertiImageUrl;
    data['last_login'] = this.lastLogin;
    data['create_dt'] = this.createDt;
    data['update_dt'] = this.updateDt;
    data['is_doctor'] = this.isDoctor;
    data['is_active'] = this.isActive;
    return data;
  }
}