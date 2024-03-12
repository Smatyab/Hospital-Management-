class ResultModel {
  int? error;
  String? message;
  Data? data;

  ResultModel({this.error, this.message, this.data});

  ResultModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  int? fieldCount;
  int? affectedRows;
  int? insertId;
  int? serverStatus;
  int? warningCount;
  String? message;
  bool? protocol41;
  int? changedRows;

  Data(
      {this.fieldCount,
      this.affectedRows,
      this.insertId,
      this.serverStatus,
      this.warningCount,
      this.message,
      this.protocol41,
      this.changedRows});

  Data.fromJson(Map<String, dynamic> json) {
    fieldCount = json['fieldCount'];
    affectedRows = json['affectedRows'];
    insertId = json['insertId'];
    serverStatus = json['serverStatus'];
    warningCount = json['warningCount'];
    message = json['message'];
    protocol41 = json['protocol41'];
    changedRows = json['changedRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldCount'] = this.fieldCount;
    data['affectedRows'] = this.affectedRows;
    data['insertId'] = this.insertId;
    data['serverStatus'] = this.serverStatus;
    data['warningCount'] = this.warningCount;
    data['message'] = this.message;
    data['protocol41'] = this.protocol41;
    data['changedRows'] = this.changedRows;
    return data;
  }
}
