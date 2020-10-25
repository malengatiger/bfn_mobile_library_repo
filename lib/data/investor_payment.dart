import 'package:bfnlibrary/data/profile.dart';
import 'package:bfnlibrary/data/supplier_payment.dart';

class InvestorPayment {
  String investorPaymentId, dateRegistered;
  SupplierPayment supplierPayment;
  InvestorProfile investorProfile;
  CustomerProfile customerProfile;

  InvestorPayment(this.investorPaymentId, this.dateRegistered,
      this.supplierPayment, this.investorProfile, this.customerProfile);
  InvestorPayment.fromJson(Map data) {
    if (data['investorProfile'] != null) {
      this.investorProfile = InvestorProfile.fromJson(data['investorProfile']);
    }
    if (data['customerProfile'] != null) {
      this.customerProfile = CustomerProfile.fromJson(data['customerProfile']);
    }
    if (data['supplierPayment'] != null) {
      this.supplierPayment = SupplierPayment.fromJson(data['supplierPayment']);
    }
    this.dateRegistered = data['dateRegistered'];
    this.investorPaymentId = data['investorPaymentId'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> mmp = Map();

    mmp['supplierPayment'] =
        supplierPayment == null ? null : supplierPayment.toJson();
    mmp['investorProfile'] =
        investorProfile == null ? null : investorProfile.toJson();
    mmp['customerProfile'] =
        customerProfile == null ? null : customerProfile.toJson();

    mmp['investorPaymentId'] = investorPaymentId;
    mmp['dateRegistered'] = dateRegistered;

    return mmp;
  }
// factory InvestorPayment.fromJson(Map<String, dynamic> json) =>
  //     _$InvestorPaymentFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$InvestorPaymentToJson(this);
  //
  // InvestorPayment(this.investorPaymentId, this.dateRegistered,
  //     this.supplierPayment, this.investorProfile, this.customerProfile);
}
