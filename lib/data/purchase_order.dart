import 'package:bfnlibrary/data/account.dart';

class PurchaseOrder {
  String purchaseOrderId;
  String purchaseOrderNumber;
  String description;
  AccountInfo supplier, customer;
  String dateRegistered;
  String amount;

  PurchaseOrder(
      {this.purchaseOrderId,
      this.purchaseOrderNumber,
      this.description,
      this.supplier,
      this.customer,
      this.dateRegistered,
      this.amount});

  PurchaseOrder.fromJson(Map data) {
    this.purchaseOrderId = data['purchaseOrderId'];
    this.purchaseOrderNumber = data['purchaseOrderNumber'];
    this.description = data['description'];
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
        'customer': customer == null ? null : customer.toJson(),
      };
}
