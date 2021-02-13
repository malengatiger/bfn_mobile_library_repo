import 'dart:async';

import 'package:bfnlibrary/api/net_util.dart';
import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:bfnlibrary/data/user.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';

class Bloc {
  BFNUser user;
  List<PurchaseOrder> _purchaseOrders = [];
  StreamController<List<PurchaseOrder>> _purchaseOrdersController =
      StreamController.broadcast();
  Stream<List<PurchaseOrder>> get purchaseOrderStream =>
      _purchaseOrdersController.stream;

  List<SupplierPayment> _supplierPayments = [];
  StreamController<List<SupplierPayment>> _supplierPaymentController =
      StreamController.broadcast();

  Stream<List<SupplierPayment>> get supplierPaymentStream =>
      _supplierPaymentController.stream;

  Future<List<SupplierPayment>> getSupplierPayments() async {
    await getUser();
    _supplierPayments = await Net.getSupplierPaymentsByCustomer(
        identifier: user.accountInfo.identifier);
    var list = await Net.getSupplierPaymentsByInvestor(
        identifier: user.accountInfo.identifier);
    _supplierPayments.addAll(list);
    var list2 = await Net.getSupplierPaymentsBySupplier(
        identifier: user.accountInfo.identifier);
    _supplierPayments.addAll(list2);

    p('🌺 🌺 🌺 ${_supplierPayments.length} _supplierPayments found and adding to stream 🌺');
    _supplierPaymentController.sink.add(_supplierPayments);
    return _supplierPayments;
  }

  Future<List<PurchaseOrder>> getPurchaseOrders(String identifier) async {
    await getUser();
    _purchaseOrders = await Net.getCustomerPurchaseOrders(identifier);
    var list = await Net.getSupplierPurchaseOrders(identifier);
    _purchaseOrders.addAll(list);
    _purchaseOrdersController.sink.add(_purchaseOrders);
    p('🌺 🌺 🌺   ${_purchaseOrders.length} _customerPurchaseOrders found and added to stream 🌺');
    return _purchaseOrders;
  }

  close() {
    _purchaseOrdersController.close();
    _supplierPaymentController.close();
  }

  Bloc() {
    p('🔵  🔵  🔵  🔵  🔵  🔵 Bloc is being constructed ... will get cached user if available');
    getUser();
  }

  Future<BFNUser> getUser() async {
    user = await Prefs.getUser();
    return user;
  }
}
