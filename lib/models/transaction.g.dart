// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction()
    ..id = json['id'] as num
    ..account_id = json['account_id'] as String
    ..creator_id = json['creator_id'] as String
    ..amount = json['amount'] as num
    ..created_at = json['created_at'] as num
    ..updated_at = json['updated_at'] as num;
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.account_id,
      'creator_id': instance.creator_id,
      'amount': instance.amount,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at
    };
