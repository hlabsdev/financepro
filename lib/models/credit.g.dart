// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credit _$CreditFromJson(Map<String, dynamic> json) {
  return Credit()
    ..id = json['id'] as num
    ..amount = json['amount'] as num
    ..interest_amount = json['interest_amount'] as num
    ..rate = json['rate'] as num
    ..payed_amount = json['payed_amount'] as num
    ..assurance_fee = json['assurance_fee'] as String
    ..demand_fee = json['demand_fee'] as String
    ..motif = json['motif'] as String
    ..warranty_name = json['warranty_name'] as String
    ..warranty_address = json['warranty_address'] as String
    ..warranty_mensuality = json['warranty_mensuality'] as String
    ..warranty_job = json['warranty_job'] as String
    ..period = json['period'] as String
    ..loan_type = json['loan_type'] as String
    ..isSpecial = json['isSpecial'] as String
    ..created_by = json['created_by'] as String
    ..account_id = json['account_id'] as String
    ..activated_by = json['activated_by'] as String
    ..state = json['state'] as bool
    ..is_closed = json['is_closed'] as bool
    ..start_date = json['start_date'] as String
    ..end_date = json['end_date'] as String
    ..created_at = json['created_at'] as num
    ..updated_at = json['updated_at'] as num;
}

Map<String, dynamic> _$CreditToJson(Credit instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'interest_amount': instance.interest_amount,
      'rate': instance.rate,
      'payed_amount': instance.payed_amount,
      'assurance_fee': instance.assurance_fee,
      'demand_fee': instance.demand_fee,
      'motif': instance.motif,
      'warranty_name': instance.warranty_name,
      'warranty_address': instance.warranty_address,
      'warranty_mensuality': instance.warranty_mensuality,
      'warranty_job': instance.warranty_job,
      'period': instance.period,
      'loan_type': instance.loan_type,
      'isSpecial': instance.isSpecial,
      'created_by': instance.created_by,
      'account_id': instance.account_id,
      'activated_by': instance.activated_by,
      'state': instance.state,
      'is_closed': instance.is_closed,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at
    };
