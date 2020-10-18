// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stellar_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StellarPayment _$StellarPaymentFromJson(Map<String, dynamic> json) {
  return StellarPayment(
    json['paymentRequestId'] as String,
    json['amount'] as String,
    json['assetCode'] as String,
    json['sourceAccount'] as String,
    json['destinationAccount'] as String,
    json['date'] as String,
    json['paymentType'] as int,
  );
}

Map<String, dynamic> _$StellarPaymentToJson(StellarPayment instance) =>
    <String, dynamic>{
      'paymentRequestId': instance.paymentRequestId,
      'amount': instance.amount,
      'assetCode': instance.assetCode,
      'sourceAccount': instance.sourceAccount,
      'destinationAccount': instance.destinationAccount,
      'date': instance.date,
      'paymentType': instance.paymentType,
    };
