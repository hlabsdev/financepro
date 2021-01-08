// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payement _$PayementFromJson(Map<String, dynamic> json) {
  return Payement()
    ..id = json['id'] as num
    ..active = json['active'] as bool
    ..loan_id = json['loan_id'] as String
    ..amount = json['amount'] as num
    ..payed = json['payed'] as num
    ..rendu = json['rendu'] as num
    ..interest_amount = json['interest_amount'] as num
    ..fix_amount = json['fix_amount'] as num
    ..payment_status = json['payment_status'] as String
    ..due_date = json['due_date'] as String
    ..date_of_payment = json['date_of_payment'] as String
    ..remarks = json['remarks'] as String
    ..created_at = json['created_at'] as num
    ..updated_at = json['updated_at'] as num;
}

Map<String, dynamic> _$PayementToJson(Payement instance) => <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'loan_id': instance.loan_id,
      'amount': instance.amount,
      'payed': instance.payed,
      'rendu': instance.rendu,
      'interest_amount': instance.interest_amount,
      'fix_amount': instance.fix_amount,
      'payment_status': instance.payment_status,
      'due_date': instance.due_date,
      'date_of_payment': instance.date_of_payment,
      'remarks': instance.remarks,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at
    };
