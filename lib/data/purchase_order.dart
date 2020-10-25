import 'package:bfnlibrary/data/account.dart';

class PurchaseOrder {
  String purchaseOrderId;
  String purchaseOrderNumber;
  String description;
  AccountInfo supplier, customer;
  String dateRegistered, invoiceCreatedDate;
  String amount, invoiceId;

  PurchaseOrder(
      {this.purchaseOrderId,
      this.purchaseOrderNumber,
      this.description,
      this.supplier,
      this.customer,
      this.invoiceCreatedDate,
      this.dateRegistered,
      this.invoiceId,
      this.amount});

  PurchaseOrder.fromJson(Map data) {
    this.purchaseOrderId = data['purchaseOrderId'];
    this.purchaseOrderNumber = data['purchaseOrderNumber'];
    this.description = data['description'];
    this.invoiceCreatedDate = data['invoiceCreatedDate'];
    this.invoiceId = data['invoiceId'];
    if (data['supplier'] != null) {
      this.supplier = AccountInfo.fromJson(data['supplier']);
    }
    if (data['customer'] != null) {
      this.customer = AccountInfo.fromJson(data['customer']);
    }
    this.dateRegistered = data['dateRegistered'];
    this.amount = data['amount'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'purchaseOrderId': purchaseOrderId,
        'purchaseOrderNumber': purchaseOrderNumber,
        'description': description,
        'supplier': supplier == null ? null : supplier.toJson(),
        'amount': amount,
        'dateRegistered': dateRegistered,
        'invoiceCreatedDate': invoiceCreatedDate,
        'invoiceId': invoiceId,
        'customer': customer == null ? null : customer.toJson(),
      };
}
