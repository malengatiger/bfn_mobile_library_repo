import 'package:json_annotation/json_annotation.dart';

import 'investor_payment.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'investor_royalty.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
///
@JsonSerializable()
class NetworkInvestorRoyalty {
  String networkRoyaltyId,
      amount,
      royaltyPercentage,
      networkOperator,
      dateRegistered;
  InvestorPayment investorPayment;

  factory NetworkInvestorRoyalty.fromJson(Map<String, dynamic> json) =>
      _$NetworkInvestorRoyaltyFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkInvestorRoyaltyToJson(this);

  NetworkInvestorRoyalty(
      this.networkRoyaltyId,
      this.amount,
      this.royaltyPercentage,
      this.networkOperator,
      this.dateRegistered,
      this.investorPayment);
}
/*
bag.dart
data class NetworkInvestorRoyaltyDTO (
        var networkRoyaltyId: String = "",
        var amount: String = "",
        var royaltyPercentage: String = "",
        var networkOperator: String = "",
        var investorPayment: InvestorPaymentDTO,
        var dateRegistered: String = ""
 */
