import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  // Transaction();

  num id;
  String account_id;
  String creator_id;
  num amount;
  num created_at;
  num updated_at;

  Transaction({
    this.id,
    this.account_id,
    this.creator_id,
    this.amount,
    this.created_at,
    this.updated_at,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
