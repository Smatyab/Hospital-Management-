class UserLogin {
  int? error;
  String? message;
  Data? data;

  UserLogin({this.error, this.message, this.data});

  UserLogin.fromJson(Map<String, dynamic> json) {
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
  String? userName;
  int? userId;
  String? lastLogin;
  String? imageUrl;

  Data({this.userName, this.userId, this.lastLogin, this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userId = json['user_id'];
    lastLogin = json['last_login'];
    imageUrl = json['image_url'];
  }

  @override
  String toString() {
    return 'Data{userName: $userName, userId: $userId, lastLogin: $lastLogin , imageUrl : $imageUrl}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    data['last_login'] = this.lastLogin;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
