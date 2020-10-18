import 'package:bfnlibrary/data/accepted_offer.dart';
import 'package:bfnlibrary/data/network_operator.dart';
import 'package:bfnlibrary/data/node_info.dart';
import 'package:bfnlibrary/data/profile.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'bag.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Bag {
  String name;
  NodeInfo nodeInfo;
  NetworkOperator networkOperator;
  List<AcceptedOffer> acceptedOffers;
  InvestorProfile investorProfile;

  factory Bag.fromJson(Map<String, dynamic> json) => _$BagFromJson(json);

  Map<String, dynamic> toJson() => _$BagToJson(this);

  Bag(this.name, this.nodeInfo, this.networkOperator, this.acceptedOffers,
      this.investorProfile);
}
