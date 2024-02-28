class DoctorLogin {
  int? error;
  String? message;
  Data? data;

  DoctorLogin({this.error, this.message, this.data});

  DoctorLogin.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  @override
  String toString() {
    return 'Login{error: $error, message: $message, data: ${data.toString()}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? doctorName;
  int? doctorId;
  String? lastLogin;
  String? imageUrl;

  Data({this.doctorName, this.doctorId, this.lastLogin, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctor_name'];
    doctorId = json['doctor_id'];
    lastLogin = json['last_login'];
    imageUrl = json['image_url'];
  }

  @override
  String toString() {
    return 'Data{doctorName: $doctorName, doctorId: $doctorId, lastLogin: $lastLogin, imageUrl : $imageUrl}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_name'] = this.doctorName;
    data['doctor_id'] = this.doctorId;
    data['last_login'] = this.lastLogin;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
