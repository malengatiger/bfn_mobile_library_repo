import 'package:bfnlibrary/data/account.dart';

class BFNUser {
  String dateRegistered;
  String email;
  String password, uid;
  String cellphone, stellarAccountId;
  AccountInfo accountInfo;

  BFNUser(
      {this.accountInfo,
      this.email,
      this.password,
      this.cellphone,
      this.uid,
      this.stellarAccountId,
      this.dateRegistered});

  BFNUser.fromJson(Map<String, dynamic> json) {
    dateRegistered = json['dateRegistered'];
    uid = json['uid'];
    email = json['email'];
    cellphone = json['cellphone'];
    password = json['password'];
    stellarAccountId = json['stellarAccountId'];
    if (json['accountInfo'] != null) {
      accountInfo = AccountInfo.fromJson(json['accountInfo']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateRegistered'] = this.dateRegistered;
    data['email'] = this.email;
    data['cellphone'] = this.cellphone;
    data['password'] = this.password;
    data['uid'] = this.uid;
    data['stellarAccountId'] = this.stellarAccountId;
    data['accountInfo'] =
        this.accountInfo == null ? null : this.accountInfo.toJson();

    return data;
  }
}
