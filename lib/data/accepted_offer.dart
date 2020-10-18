import 'package:bfnlibrary/data/account.dart';

class AcceptedOffer {
  String invoiceId, offerId;
  AccountInfo supplier, investor, customer;
  String offerDate;
  String offerAmount, discount, originalAmount;
  String investorDate, externalId;
  String invoiceNumber, acceptanceDate, dateRegistered;

  AcceptedOffer(
      {this.invoiceId,
      this.supplier,
      this.investor,
      this.offerDate,
      this.offerAmount,
      this.discount,
      this.originalAmount,
      this.offerId,
      this.investorDate,
      this.acceptanceDate,
      this.dateRegistered,
      this.externalId,
      this.customer,
      this.invoiceNumber});

  AcceptedOffer.fromJson(Map data) {
    this.invoiceId = data['invoiceId'];
    this.offerId = data['offerId'];

    this.investorDate = data['investorDate'];
    this.acceptanceDate = data['acceptanceDate'];
    this.dateRegistered = data['dateRegistered'];
    this.externalId = data['externalId'];
    this.invoiceNumber = data['invoiceNumber'];

    if (data['customer'] != null) {
      this.customer = AccountInfo.fromJson(data['customer']);
    }
    if (data['supplier'] != null) {
      this.supplier = AccountInfo.fromJson(data['supplier']);
    }
    if (data['investor'] != null) {
      this.investor = AccountInfo.fromJson(data['investor']);
    }
    this.offerDate = data['offerDate'];
    if (data['offerAmount'] is int) {
      this.offerAmount = data['offerAmount'] * 1.00;
    }
    if (data['offerAmount'] is double) {
      this.offerAmount = data['offerAmount'];
    }
    if (data['discount'] is int) {
      this.discount = data['discount'] * 1.00;
    }
    if (data['discount'] is double) {
      this.discount = data['discount'];
    }
    this.investorDate = data['investorDate'];
    if (data['originalAmount'] is int) {
      this.originalAmount = data['originalAmount'] * 1.00;
    }
    if (data['originalAmount'] is double) {
      this.originalAmount = data['originalAmount'];
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'invoiceId': invoiceId,
        'offerId': offerId,
        'supplier': supplier.toJson(),
        'offerAmount': offerAmount,
        'discount': discount,
        'investorDate': investorDate,
        'offerDate': offerDate,
        'investor': investor.toJson(),
        'customer': customer.toJson(),
        'originalAmount': originalAmount,
        'invoiceNumber': invoiceNumber,
        'acceptanceDate': acceptanceDate,
        'dateRegistered': dateRegistered,
        'externalId': externalId,
      };
}
