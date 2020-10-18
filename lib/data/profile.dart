import 'package:bfnlibrary/data/account.dart';
import 'package:flutter/cupertino.dart';

class InvestorProfile {
  String bank, stellarAccountId, rippleAccountId;
  String bankAccount, dateRegistered;
  String minimumInvoiceAmount, defaultDiscount;
  String maximumInvoiceAmount, totalInvestment;
  List<TradeMatrixItem> tradeMatrixItems;
  AccountInfo account;

  InvestorProfile(
      {this.bank,
      @required this.bankAccount,
      @required this.minimumInvoiceAmount,
      @required this.totalInvestment,
      @required this.defaultDiscount,
      @required this.dateRegistered,
      @required this.stellarAccountId,
      @required this.rippleAccountId,
      @required this.tradeMatrixItems,
      @required this.account,
      @required this.maximumInvoiceAmount});

  InvestorProfile.fromJson(Map data) {
    if (data['account'] != null) {
      this.account = AccountInfo.fromJson(data['account']);
    }
    this.bank = data['bank'];
    this.bankAccount = data['bankAccount'];
    this.minimumInvoiceAmount = data['minimumInvoiceAmount'];
    this.maximumInvoiceAmount = data['maximumInvoiceAmount'];
    this.defaultDiscount = data['defaultDiscount'];
    this.dateRegistered = data['dateRegistered'];
    this.totalInvestment = data['totalInvestment'];

    this.stellarAccountId = data['stellarAccountId'];
    this.rippleAccountId = data['rippleAccountId'];
    this.tradeMatrixItems = [];
    if (data['tradeMatrixItems'] != null) {
      List m = data['tradeMatrixItems'];
      m.forEach((element) {
        this.tradeMatrixItems.add(TradeMatrixItem.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = Map();
    List<Map<String, dynamic>> trades = [];
    if (tradeMatrixItems.isNotEmpty) {
      tradeMatrixItems.forEach((element) {
        trades.add(element.toJson());
      });
    }

    m['bank'] = bank;
    m['account'] = account == null ? '' : account.toJson();
    m['bankAccount'] = bankAccount;
    m['minimumInvoiceAmount'] = minimumInvoiceAmount;
    m['maximumInvoiceAmount'] = maximumInvoiceAmount;
    m['dateRegistered'] = dateRegistered;
    m['defaultDiscount'] = defaultDiscount;
    m['totalInvestment'] = totalInvestment;
    m['stellarAccountId'] = stellarAccountId;
    m['rippleAccountId'] = rippleAccountId;
    m['tradeMatrixItems'] = trades;

    return m;
  }
}

class SupplierProfile {
  AccountInfo account;
  String bank, name;
  String bankAccount, stellarAccountId;
  String maximumDiscount, rippleAccountId, assetCode, dateRegistered;

  SupplierProfile(
      {this.bank,
      @required this.bankAccount,
      @required this.stellarAccountId,
      @required this.rippleAccountId,
      @required this.assetCode,
      @required this.name,
      @required this.dateRegistered,
      @required this.maximumDiscount});

  SupplierProfile.fromJson(Map data) {
    this.bank = data['bank'];
    this.name = data['name'];
    this.bankAccount = data['bankAccount'];
    this.maximumDiscount = data['maximumDiscount'];
    this.stellarAccountId = data['stellarAccountId'];

    this.rippleAccountId = data['rippleAccountId'];
    this.assetCode = data['assetCode'];
    this.dateRegistered = data['dateRegistered'];
    if (data['account'] != null) {
      this.account = AccountInfo.fromJson(data['account']);
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'bank': bank,
        'name': name == null ? '' : name,
        'bankAccount': bankAccount,
        'maximumDiscount': maximumDiscount,
        'stellarAccountId': stellarAccountId,
        'rippleAccountId': rippleAccountId,
        'assetCode': assetCode,
        'dateRegistered': dateRegistered,
        'account': account == null ? null : account.toJson(),
      };
}

class TradeMatrixItem {
  String startInvoiceAmount;
  String endInvoiceAmount, offerDiscount;
  String date;

  TradeMatrixItem(
      {this.startInvoiceAmount,
      @required this.endInvoiceAmount,
      @required this.offerDiscount,
      @required this.date});

  TradeMatrixItem.fromJson(Map data) {
    this.startInvoiceAmount = data['startInvoiceAmount'];
    this.endInvoiceAmount = data['endInvoiceAmount'];
    this.date = data['date'];
    this.offerDiscount = data['offerDiscount'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'startInvoiceAmount': startInvoiceAmount,
        'endInvoiceAmount': endInvoiceAmount,
        'date': date,
        'offerDiscount': offerDiscount,
      };
}

class CustomerProfile {
  String minimumInvoiceAmount;
  String maximumInvoiceAmount, dateRegistered;
  String email, stellarAccountId, rippleAccountId, cellphone;
  AccountInfo account;

  CustomerProfile(
      {this.minimumInvoiceAmount,
      @required this.maximumInvoiceAmount,
      @required this.dateRegistered,
      @required this.email,
      @required this.account,
      @required this.stellarAccountId,
      @required this.rippleAccountId,
      @required this.cellphone});

  CustomerProfile.fromJson(Map data) {
    this.minimumInvoiceAmount = data['minimumInvoiceAmount'];
    this.maximumInvoiceAmount = data['maximumInvoiceAmount'];
    this.email = data['email'];
    if (data['account'] != null) {
      this.account = AccountInfo.fromJson(data['account']);
    }
    this.dateRegistered = data['dateRegistered'];

    this.cellphone = data['cellphone'];
    this.stellarAccountId = data['stellarAccountId'];
    this.rippleAccountId = data['rippleAccountId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'minimumInvoiceAmount': minimumInvoiceAmount,
        'maximumInvoiceAmount': maximumInvoiceAmount,
        'email': email,
        'account': account == null ? '' : account.toJson(),
        'dateRegistered': dateRegistered,
        'rippleAccountId': rippleAccountId,
        'stellarAccountId': stellarAccountId,
        'cellphone': cellphone,
      };
}
