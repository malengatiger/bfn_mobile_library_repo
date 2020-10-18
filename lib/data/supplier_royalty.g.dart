// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_royalty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkSupplierRoyalty _$NetworkSupplierRoyaltyFromJson(
    Map<String, dynamic> json) {
  return NetworkSupplierRoyalty(
    json['networkRoyaltyId'] as String,
    json['amount'] as String,
    json['royaltyPercentage'] as String,
    json['networkOperator'] as String,
    json['dateRegistered'] as String,
    json['investorPayment'] == null
        ? null
        : SupplierPayment.fromJson(
            json['investorPayment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NetworkSupplierRoyaltyToJson(
        NetworkSupplierRoyalty instance) =>
    <String, dynamic>{
      'networkRoyaltyId': instance.networkRoyaltyId,
      'amount': instance.amount,
      'royaltyPercentage': instance.royaltyPercentage,
      'networkOperator': instance.networkOperator,
      'dateRegistered': instance.dateRegistered,
      'investorPayment': instance.investorPayment,
    };
