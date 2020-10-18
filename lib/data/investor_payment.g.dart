// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investor_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestorPayment _$InvestorPaymentFromJson(Map<String, dynamic> json) {
  return InvestorPayment(
    json['investorPaymentId'] as String,
    json['dateRegistered'] as String,
    json['supplierPayment'] == null
        ? null
        : SupplierPayment.fromJson(
            json['supplierPayment'] as Map<String, dynamic>),
    json['investorProfile'] == null
        ? null
        : InvestorProfile.fromJson(
            json['investorProfile'] as Map<String, dynamic>),
    json['customerProfile'] == null
        ? null
        : CustomerProfile.fromJson(
            json['customerProfile'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InvestorPaymentToJson(InvestorPayment instance) =>
    <String, dynamic>{
      'investorPaymentId': instance.investorPaymentId,
      'dateRegistered': instance.dateRegistered,
      'supplierPayment': instance.supplierPayment,
      'investorProfile': instance.investorProfile,
      'customerProfile': instance.customerProfile,
    };
