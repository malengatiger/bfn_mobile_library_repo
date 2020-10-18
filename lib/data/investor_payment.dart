import 'package:bfnlibrary/data/profile.dart';
import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'investor_payment.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class InvestorPayment {
  String investorPaymentId, dateRegistered;
  SupplierPayment supplierPayment;
  InvestorProfile investorProfile;
  CustomerProfile customerProfile;

  factory InvestorPayment.fromJson(Map<String, dynamic> json) =>
      _$InvestorPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$InvestorPaymentToJson(this);

  InvestorPayment(this.investorPaymentId, this.dateRegistered,
      this.supplierPayment, this.investorProfile, this.customerProfile);
}
