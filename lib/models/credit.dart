import 'package:json_annotation/json_annotation.dart';

part 'credit.g.dart';

@JsonSerializable()
class Credit {
  // Credit();

  num id;
  num amount;
  num interest_amount;
  num rate;
  num payed_amount;
  String assurance_fee;
  String demand_fee;
  String motif;
  String warranty_name;
  String warranty_address;
  String warranty_mensuality;
  String warranty_job;
  String period;
  String loan_type;
  String isSpecial;
  String created_by;
  String account_id;
  String activated_by;
  bool state;
  bool is_closed;
  String start_date;
  String end_date;
  num created_at;
  num updated_at;

  Credit({
    this.id,
    this.amount,
    this.interest_amount,
    this.rate,
    this.payed_amount,
    this.assurance_fee,
    this.demand_fee,
    this.motif,
    this.warranty_name,
    this.warranty_address,
    this.warranty_mensuality,
    this.warranty_job,
    this.period,
    this.loan_type,
    this.isSpecial,
    this.created_by,
    this.account_id,
    this.activated_by,
    this.state,
    this.is_closed,
    this.start_date,
    this.end_date,
    this.created_at,
    this.updated_at,
  });

  factory Credit.fromJson(Map<String, dynamic> json) => _$CreditFromJson(json);
  Map<String, dynamic> toJson() => _$CreditToJson(this);
}
