import 'package:bfnlibrary/data/account.dart';

class Invoice {
  String invoiceId;
  String invoiceNumber;
  String description;
  AccountInfo supplier, customer;
  String dateRegistered;
  String amount, valueAddedTax, totalAmount;

  Invoice(
      {this.invoiceId,
      this.invoiceNumber,
      this.description,
      this.supplier,
      this.customer,
      this.dateRegistered,
      this.amount,
      this.valueAddedTax,
      this.totalAmount});

  Invoice.fromJson(Map data) {
    this.invoiceId = data['invoiceId'];
    this.invoiceNumber = data['invoiceNumber'];
    this.description = data['description'];
    if (data['supplier'] != null) {
      this.supplier = AccountInfo.fromJson(data['supplier']);
    }
    if (data['customer'] != null) {
      this.customer = AccountInfo.fromJson(data['customer']);
    }
    this.dateRegistered = data['dateRegistered'];
    this.amount = data['amount'];
    this.valueAddedTax = data['valueAddedTax'];
    this.totalAmount = data['totalAmount'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'invoiceId': invoiceId,
        'invoiceNumber': invoiceNumber,
        'description': description,
        'supplier': supplier.toJson(),
        'amount': amount,
        'valueAddedTax': valueAddedTax,
        'totalAmount': totalAmount,
        'dateRegistered': dateRegistered,
        'customer': customer.toJson(),
      };
}
