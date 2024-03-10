class Patient {
  int? error;
  String? message;
  List<Data>? data;

  Patient({this.error, this.message, this.data});

  Patient.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? patientId;
  String? patientName;
  String? emailId;
  String? phoneNo;
  String? gender;
  String? dateOfBirth;
  String? imageUrl;
  String? height;
  String? weight;
  String? bloodGroup;
  String? allegeries;
  String? diseases;
  String? bloodPressure;
  String? bodyTemp;
  String? bloodLevel;
  String? heartRate;
  String? glucoseRate;
  String? colestrol;
  String? lastLogin;
  String? createDt;
  String? updateDt;
  int? isActive;

  Data(
      {this.patientId,
      this.patientName,
      this.emailId,
      this.phoneNo,
      this.gender,
      this.dateOfBirth,
      this.imageUrl,
      this.height,
      this.weight,
      this.bloodGroup,
      this.allegeries,
      this.diseases,
      this.bloodPressure,
      this.bodyTemp,
      this.bloodLevel,
      this.heartRate,
      this.glucoseRate,
      this.colestrol,
      this.lastLogin,
      this.createDt,
      this.updateDt,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    emailId = json['email_id'];
    phoneNo = json['phone_no'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    imageUrl = json['image_url'];
    height = json['height'];
    weight = json['weight'];
    bloodGroup = json['blood_group'];
    allegeries = json['allegeries'];
    diseases = json['diseases'];
    bloodPressure = json['blood_pressure'];
    bodyTemp = json['body_temp'];
    bloodLevel = json['blood_level'];
    heartRate = json['heart_rate'];
    glucoseRate = json['glucose_rate'];
    colestrol = json['colestrol'];
    lastLogin = json['last_login'];
    createDt = json['create_dt'];
    updateDt = json['update_dt'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    data['email_id'] = this.emailId;
    data['phone_no'] = this.phoneNo;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['image_url'] = this.imageUrl;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['blood_group'] = this.bloodGroup;
    data['allegeries'] = this.allegeries;
    data['diseases'] = this.diseases;
    data['blood_pressure'] = this.bloodPressure;
    data['body_temp'] = this.bodyTemp;
    data['blood_level'] = this.bloodLevel;
    data['heart_rate'] = this.heartRate;
    data['glucose_rate'] = this.glucoseRate;
    data['colestrol'] = this.colestrol;
    data['last_login'] = this.lastLogin;
    data['create_dt'] = this.createDt;
    data['update_dt'] = this.updateDt;
    data['is_active'] = this.isActive;
    return data;
  }
}
