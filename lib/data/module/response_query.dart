class ResponseQuery {
  int? error;
  String? message;
  Result? data;

  ResponseQuery({this.error, this.message, this.data});

  ResponseQuery.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Result.fromJson(json['data']) : null;
  }

  @override
  String toString() {
    return 'ResponseQuery{error: $error, message: $message, data: $data}';
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


class Result {
  int? fieldCount;
  int? affectedRows;
  int? insertId;
  int? serverStatus;
  int? warningCount;
  String? message;
  bool? protocol41;
  int? changedRows;

  Result(
      {this.fieldCount,
        this.affectedRows,
        this.insertId,
        this.serverStatus,
        this.warningCount,
        this.message,
        this.protocol41,
        this.changedRows});

  Result.fromJson(Map<String, dynamic> json) {
    fieldCount = json['fieldCount'];
    affectedRows = json['affectedRows'];
    insertId = json['insertId'];
    serverStatus = json['serverStatus'];
    warningCount = json['warningCount'];
    message = json['message'];
    protocol41 = json['protocol41'];
    changedRows = json['changedRows'];
  }

  @override
  String toString() {
    return 'Result{fieldCount: $fieldCount, affectedRows: $affectedRows, insertId: $insertId, serverStatus: $serverStatus, warningCount: $warningCount, message: $message, protocol41: $protocol41, changedRows: $changedRows}';
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
