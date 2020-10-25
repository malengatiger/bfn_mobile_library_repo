import 'package:bfnlibrary/data/invoice_offer.dart';
import 'package:bfnlibrary/data/profile.dart';

class SupplierPayment {
  InvoiceOffer acceptedOffer;
  SupplierProfile supplierProfile;
  CustomerProfile customerProfile;
  String supplierPaymentId;
  String dateRegistered;

  SupplierPayment(
      {this.acceptedOffer,
      this.supplierProfile,
      this.supplierPaymentId,
      this.dateRegistered});

  SupplierPayment.fromJson(Map data) {
    if (data['supplierProfile'] != null) {
      this.supplierProfile = SupplierProfile.fromJson(data['supplierProfile']);
    }
    if (data['customerProfile'] != null) {
      this.customerProfile = CustomerProfile.fromJson(data['customerProfile']);
    }
    if (data['acceptedOffer'] != null) {
      this.acceptedOffer = InvoiceOffer.fromJson(data['acceptedOffer']);
    }
    this.dateRegistered = data['dateRegistered'];
    this.supplierPaymentId = data['supplierPaymentId'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> mmp = Map();

    mmp['acceptedOffer'] =
        acceptedOffer == null ? null : acceptedOffer.toJson();
    mmp['supplierProfile'] =
        supplierProfile == null ? null : supplierProfile.toJson();
    mmp['customerProfile'] =
        customerProfile == null ? null : customerProfile.toJson();
    mmp['supplierPaymentId'] = supplierPaymentId;
    mmp['dateRegistered'] = dateRegistered;

    return mmp;
  }
}

class TradeMatrix {
  double startInvoiceAmount;
  double endInvoiceAmount;
  double offerDiscount;
  String dateRegistered;
  String id;
  int maximumInvoiceAgeInDays;

  TradeMatrix(
      {this.startInvoiceAmount,
      this.endInvoiceAmount,
      this.offerDiscount,
      this.dateRegistered,
      this.id,
      this.maximumInvoiceAgeInDays});

  TradeMatrix.fromJson(Map data) {
    this.startInvoiceAmount = data['startInvoiceAmount'];
    this.endInvoiceAmount = data['endInvoiceAmount'];
    this.maximumInvoiceAgeInDays = data['maximumInvoiceAgeInDays'];
    this.offerDiscount = data['offerDiscount'];
    this.dateRegistered = data['dateRegistered'];
    this.id = data['id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'startInvoiceAmount': startInvoiceAmount,
        'endInvoiceAmount': endInvoiceAmount,
        'maximumInvoiceAgeInDays': maximumInvoiceAgeInDays,
        'dateRegistered': dateRegistered,
        'id': id,
        'offerDiscount': offerDiscount,
      };
}
