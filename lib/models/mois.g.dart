// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mois.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mois _$MoisFromJson(Map<String, dynamic> json) {
  return Mois()
    ..id = json['id'] as num
    ..account_id = json['account_id'] as String
    ..position = json['position'] as num
    ..year = json['year'] as num
    ..month = json['month'] as num
    ..mise = json['mise'] as num
    ..is_taken = json['is_taken'] as bool
    ..created_at = json['created_at'] as num
    ..updated_at = json['updated_at'] as num;
}

Map<String, dynamic> _$MoisToJson(Mois instance) => <String, dynamic>{
      'id': instance.id,
      'account_id': instance.account_id,
      'position': instance.position,
      'year': instance.year,
      'month': instance.month,
      'mise': instance.mise,
      'is_taken': instance.is_taken,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at
    };
