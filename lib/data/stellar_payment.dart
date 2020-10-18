import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'stellar_payment.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
///
@JsonSerializable()
class StellarPayment {
  String paymentRequestId,
      amount,
      assetCode,
      sourceAccount,
      destinationAccount,
      date;
  int paymentType;

  factory StellarPayment.fromJson(Map<String, dynamic> json) =>
      _$StellarPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$StellarPaymentToJson(this);

  StellarPayment(this.paymentRequestId, this.amount, this.assetCode,
      this.sourceAccount, this.destinationAccount, this.date, this.paymentType);
}

const int PAYMENT_SUPPLIER = 1;
const int PAYMENT_INVESTOR = 2;
const int PAYMENT_ROYALTY = 3;
const int PAYMENT_FUNDING = 4;
