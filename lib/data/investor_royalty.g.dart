// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investor_royalty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkInvestorRoyalty _$NetworkInvestorRoyaltyFromJson(
    Map<String, dynamic> json) {
  return NetworkInvestorRoyalty(
    json['networkRoyaltyId'] as String,
    json['amount'] as String,
    json['royaltyPercentage'] as String,
    json['networkOperator'] as String,
    json['dateRegistered'] as String,
    json['investorPayment'] == null
        ? null
        : InvestorPayment.fromJson(
            json['investorPayment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NetworkInvestorRoyaltyToJson(
        NetworkInvestorRoyalty instance) =>
    <String, dynamic>{
      'networkRoyaltyId': instance.networkRoyaltyId,
      'amount': instance.amount,
      'royaltyPercentage': instance.royaltyPercentage,
      'networkOperator': instance.networkOperator,
      'dateRegistered': instance.dateRegistered,
      'investorPayment': instance.investorPayment,
    };
