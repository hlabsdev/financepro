import 'package:json_annotation/json_annotation.dart';

part 'type_acc.g.dart';

@JsonSerializable()
class Type_acc {
  // Type_acc();

  num id;
  String balance;
  String acc_num;
  String client_id;
  String creator_id;
  String account_type_id;
  bool state;
  num amount_blocked;
  num nanti;
  num block_period;
  String block_end_date;
  String mise;
  num created_at;
  num updated_at;

  Type_acc({
    this.id,
    this.balance,
    this.acc_num,
    this.client_id,
    this.creator_id,
    this.account_type_id,
    this.state,
    this.amount_blocked,
    this.nanti,
    this.block_period,
    this.block_end_date,
    this.mise,
    this.created_at,
    this.updated_at,
  });

  factory Type_acc.fromJson(Map<String, dynamic> json) =>
      _$Type_accFromJson(json);
  Map<String, dynamic> toJson() => _$Type_accToJson(this);
}
