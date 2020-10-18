// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bag _$BagFromJson(Map<String, dynamic> json) {
  return Bag(
    json['name'] as String,
    json['nodeInfo'] == null
        ? null
        : NodeInfo.fromJson(json['nodeInfo'] as Map<String, dynamic>),
    json['networkOperator'] == null
        ? null
        : NetworkOperator.fromJson(
            json['networkOperator'] as Map<String, dynamic>),
    (json['acceptedOffers'] as List)
        ?.map((e) => e == null
            ? null
            : AcceptedOffer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['investorProfile'] == null
        ? null
        : InvestorProfile.fromJson(
            json['investorProfile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BagToJson(Bag instance) => <String, dynamic>{
      'name': instance.name,
      'nodeInfo': instance.nodeInfo,
      'networkOperator': instance.networkOperator,
      'acceptedOffers': instance.acceptedOffers,
      'investorProfile': instance.investorProfile,
    };
