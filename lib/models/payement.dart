import 'package:json_annotation/json_annotation.dart';

part 'payement.g.dart';

@JsonSerializable()
class Payement {
  // Payement();

  num id;
  bool active;
  String loan_id;
  num amount;
  num payed;
  num rendu;
  num interest_amount;
  num fix_amount;
  String payment_status;
  String due_date;
  String date_of_payment;
  String remarks;
  num created_at;
  num updated_at;

  Payement({
    this.id,
    this.active,
    this.loan_id,
    this.amount,
    this.payed,
    this.rendu,
    this.interest_amount,
    this.fix_amount,
    this.payment_status,
    this.due_date,
    this.date_of_payment,
    this.remarks,
    this.created_at,
    this.updated_at,
  });

  factory Payement.fromJson(Map<String, dynamic> json) =>
      _$PayementFromJson(json);
  Map<String, dynamic> toJson() => _$PayementToJson(this);
}
