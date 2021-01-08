// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_acc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Type_acc _$Type_accFromJson(Map<String, dynamic> json) {
  return Type_acc()
    ..id = json['id'] as num
    ..balance = json['balance'] as String
    ..acc_num = json['acc_num'] as String
    ..client_id = json['client_id'] as String
    ..creator_id = json['creator_id'] as String
    ..account_type_id = json['account_type_id'] as String
    ..state = json['state'] as bool
    ..amount_blocked = json['amount_blocked'] as num
    ..nanti = json['nanti'] as num
    ..block_period = json['block_period'] as num
    ..block_end_date = json['block_end_date'] as String
    ..mise = json['mise'] as String
    ..created_at = json['created_at'] as num
    ..updated_at = json['updated_at'] as num;
}

Map<String, dynamic> _$Type_accToJson(Type_acc instance) => <String, dynamic>{
      'id': instance.id,
      'balance': instance.balance,
      'acc_num': instance.acc_num,
      'client_id': instance.client_id,
      'creator_id': instance.creator_id,
      'account_type_id': instance.account_type_id,
      'state': instance.state,
      'amount_blocked': instance.amount_blocked,
      'nanti': instance.nanti,
      'block_period': instance.block_period,
      'block_end_date': instance.block_end_date,
      'mise': instance.mise,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at
    };
