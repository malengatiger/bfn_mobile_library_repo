import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'supplier_royalty.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
///
@JsonSerializable()
class NetworkSupplierRoyalty {
  String networkRoyaltyId,
      amount,
      royaltyPercentage,
      networkOperator,
      dateRegistered;
  SupplierPayment investorPayment;

  factory NetworkSupplierRoyalty.fromJson(Map<String, dynamic> json) =>
      _$NetworkSupplierRoyaltyFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkSupplierRoyaltyToJson(this);

  NetworkSupplierRoyalty(
      this.networkRoyaltyId,
      this.amount,
      this.royaltyPercentage,
      this.networkOperator,
      this.dateRegistered,
      this.investorPayment);
}
