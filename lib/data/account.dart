import 'package:bfnlibrary/util/functions.dart';

class AccountInfo {
  String identifier;
  String host;
  String name;
  String status;

  AccountInfo({this.identifier, this.host, this.name, this.status});

  AccountInfo.fromJson(Map data) {
    p(' 🍊 🍊 🍊 🍊 🍊 AccountInfo.fromJson 🍊 🍊 🍊 🍊 🍊');
    p(data.toString());
    this.identifier = data['identifier'];
    this.host = data['host'];
    this.name = data['name'];
    this.status = data['status'];
    prettyPrint(this.toJson(), " 🍊 🍊 check for nulls in this accountInfo");
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'identifier': identifier,
        'host': host,
        'name': name,
        'status': status,
      };
}
