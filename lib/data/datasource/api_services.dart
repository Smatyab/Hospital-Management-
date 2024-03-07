import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hophseeflutter/core/share_preference.dart';
import 'package:hophseeflutter/data/module/doctor_login_model.dart';
import 'package:hophseeflutter/data/module/doctor_model.dart';
import 'package:hophseeflutter/data/module/payment_model.dart';
import 'package:hophseeflutter/data/module/payment_page_required.dart';
import 'package:intl/intl.dart';

import '../../core/constant.dart';
import '../../core/utils.dart';
import '../../ui/appointment/appointment_list_screen.dart';
import '../module/appo_model.dart';
import '../module/user_login_model.dart';
import '../module/response_query.dart';
import '../module/user_model.dart';

abstract class ApiService {
  Future<UserLogin> loginUser(String email, String password);

  Future<DoctorLogin> loginDoctor(String email, String password);

  Future<ResponseQuery> registerUser(User user, File file);

  Future<DoctorList> getDoctorList();

  Future<UserModel> getUserList();

  Future<ResponseQuery> addPaymentDetails(
      PaymentPageRequired paymentPageRequired, int amount);

  Future<ResponseQuery> addAppointment(
      PaymentPageRequired paymentPageRequired, int paymentId);

  Future<UserModel> getUserById(int userId);

  Future<AppoList> getAppoList(
      {int? doctorId, int? userId, int? isHospitalVisit});

  Future<DoctorList> getDoctorById(int doctorId);

  Future<ResponseQuery> editUserProfile(int userId, String userName,
      String emailId, String phoneNumber, String gender);

  Future<ResponseQuery> editDoctorProfile(int userId, String userName,
      String emailId, String phoneNumber, String gender);

  Future<ResponseQuery> removeAppointment(int appoId);
}

class ApiServiceImpl extends ApiService {
  Dio dio;

  ApiServiceImpl(this.dio);

  @override
  Future<UserLogin> loginUser(String email, String password) async {
    try {
      Map<String, String> params = {};
      params['email_id'] = email;
      params['password'] = password;
      final response = await dio.post(
        loginUserEp,
        data: params,
      );
      UserLogin loginResponse = UserLogin.fromJson(response.data);
      print("Api Response login : ${loginResponse.toString()}");
      return loginResponse;
    } on Exception catch (error) {
      return UserLogin.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<DoctorLogin> loginDoctor(String email, String password) async {
    try {
      Map<String, String> params = {};
      params['email_id'] = email;
      params['password'] = password;
      final response = await dio.post(
        loginDoctorEp,
        data: params,
      );
      DoctorLogin loginResponse = DoctorLogin.fromJson(response.data);
      print("Api Response login : ${loginResponse.toString()}");
      return loginResponse;
    } on Exception catch (error) {
      return DoctorLogin.fromJson(getErrorMap("Http Error"));
    }
  }

  Map<String, dynamic> getErrorMap(String errorMessage) {
    return {"error": true, "message": errorMessage, "data": null};
  }

  @override
  Future<ResponseQuery> registerUser(User user, File file) async {
    try {
      String fileName = file.path.split('/').last;
      print("File Path ${file.path} file name : $fileName");
      String userName = user.userName ?? "";
      String emailId = user.emailId ?? "";
      String phoneNo = user.phoneNo ?? "";
      String password = user.password ?? "";
      String gender = user.gender ?? "";
      String dateOfBirth = user.dateOfBirth ?? "";
      int isDoctor = 0;
      int isActive = 1;
      FormData formData = FormData.fromMap({
        "image_url":
            await MultipartFile.fromFile(file.path, filename: fileName),
        "user_name": userName,
        "email_id": emailId,
        "phone_no": phoneNo,
        "password": password,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "is_doctor": isDoctor,
        "is_active": isActive
      });
      print("formdata : ${formData.fields}");
      final response = await dio.post(
        userEp,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      ResponseQuery registerUserResponse =
          ResponseQuery.fromJson(response.data);
      print("Api Response login : ${registerUserResponse.toString()}");
      return registerUserResponse;
    } on Exception catch (error) {
      return ResponseQuery.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<DoctorList> getDoctorList() async {
    try {
      final response = await dio.get(
        doctorEp,
      );
      DoctorList doctorsResponse = DoctorList.fromJson(response.data);
      return doctorsResponse;
    } on Exception catch (error) {
      return DoctorList.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<DoctorList> getDoctorById(int doctorId) async {
    try {
      final response = await dio.get(
        "$doctorEp/$doctorId",
      );
      DoctorList doctorsResponse = DoctorList.fromJson(response.data);
      return doctorsResponse;
    } on Exception catch (error) {
      return DoctorList.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<UserModel> getUserList() async {
    try {
      final response = await dio.get(
        userEp,
      );
      UserModel userRes = UserModel.fromJson(response.data);
      return userRes;
    } on Exception catch (error) {
      return UserModel.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<UserModel> getUserById(int userId) async {
    try {
      String apiEP = "$userEp/$userId";
      print("apiEP : $apiEP");
      final response = await dio.get(
        apiEP,
      );
      print("response : ${response.data} -- $response");
      UserModel userResponse = UserModel.fromJson(response.data);
      print("userResponse : $userResponse");
      return userResponse;
    } on Exception catch (error) {
      return UserModel.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<ResponseQuery> addPaymentDetails(
      PaymentPageRequired paymentPageRequired, int amount) async {
    try {
      Map<String, dynamic> data = {};
      data["payment_ref_no"] =
          "${paymentPageRequired.doctorId}${DateTime.now()}";
      int userId =
          await Preference.getValueFromSharedPreferences(USER_ID_PREFERENCE);
      data["payer_id"] = userId;
      data["payee_id"] = 7;
      data["payer_type"] = "user";
      data["payee_type"] = "admin";
      data["admin_id"] = 7;
      data["payment_ammount"] = amount;

      final response = await dio.post(
        paymentEp,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Set the Content-Type header
          },
        ),
      );
      ResponseQuery registerUserResponse =
          ResponseQuery.fromJson(response.data);
      return registerUserResponse;
    } on Exception catch (error) {
      return ResponseQuery.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<ResponseQuery> addAppointment(
      PaymentPageRequired paymentPageRequired, int paymentId) async {
    try {
      Map<String, dynamic> data = {};
      int userId =
          await Preference.getValueFromSharedPreferences(USER_ID_PREFERENCE);
      data["user_id"] = userId;
      data["doctor_id"] = paymentPageRequired.doctorId;
      data["payment_id"] = paymentId;
      data["appo_dt"] = convertToyyyymmdd(paymentPageRequired.appoDt ?? "");
      data["appo_time"] = paymentPageRequired.appoTime;
      /* String date = convertToyyyymmdd(paymentPageRequired.appoDt ?? "");
      String dateString = "$date${paymentPageRequired.appoTime}";
      DateTime dateTime = DateTime.parse(dateString);
      String isoTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
      data["appo_dt"] = date;
      data["appo_time"] = isoTime;*/
      data["is_approve"] = true;

      print("1>>>> appo_dt ${paymentPageRequired.appoDt}");
      print("1>>>> appo_time ${paymentPageRequired.appoTime}");

      final response = await dio.post(
        appoEp,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Set the Content-Type header
          },
        ),
      );
      ResponseQuery registerUserResponse =
          ResponseQuery.fromJson(response.data);
      return registerUserResponse;
    } on Exception catch (error) {
      return ResponseQuery.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<ResponseQuery> editUserProfile(int userId, String userName,
      String emailId, String phoneNumber, String gender) async {
    try {
      Map<String, dynamic> data = {};
      data["user_id"] = userId;
      data["user_name"] = userName;
      data["email_id"] = emailId;
      data["phone_no"] = phoneNumber;
      data["gender"] = gender;
      final response = await dio.patch(
        userEp,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Set the Content-Type header
          },
        ),
      );
      ResponseQuery registerUserResponse =
          ResponseQuery.fromJson(response.data);
      return registerUserResponse;
    } on Exception catch (error) {
      return ResponseQuery.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<AppoList> getAppoList(
      {int? doctorId, int? userId, int? isHospitalVisit}) async {
    try {
      final response = await dio.get(appoEp, queryParameters: {
        "user_id": userId,
        "doctor_id": doctorId,
        "is_hospital_visit": isHospitalVisit
      });
      print("object api call : ${response.realUri}");
      AppoList appoListResponse = AppoList.fromJson(response.data);
      return appoListResponse;
    } on Exception catch (error) {
      return AppoList.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<ResponseQuery> editDoctorProfile(int userId, String userName,
      String emailId, String phoneNumber, String gender) async {
    try {
      Map<String, dynamic> data = {};
      data["doctor_id"] = userId;
      data["doctor_name"] = userName;
      data["email_id"] = emailId;
      data["phone_no"] = phoneNumber;
      data["gender"] = gender;
      final response = await dio.patch(
        doctorEp,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Set the Content-Type header
          },
        ),
      );
      ResponseQuery registerUserResponse =
          ResponseQuery.fromJson(response.data);
      return registerUserResponse;
    } on Exception catch (error) {
      return ResponseQuery.fromJson(getErrorMap("Http Error"));
    }
  }

  @override
  Future<ResponseQuery> removeAppointment(int appoId) async {
    try {
      final response = await dio.delete(
        "$appoEp/$appoId",
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Set the Content-Type header
          },
        ),
      );
      ResponseQuery registerUserResponse =
          ResponseQuery.fromJson(response.data);
      return registerUserResponse;
    } on Exception catch (error) {
      return ResponseQuery.fromJson(getErrorMap("Http Error"));
    }
  }
}
