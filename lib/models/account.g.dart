// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account()
    ..epargne = json['epargne'] == null
        ? null
        : Type_acc.fromJson(json['epargne'] as Map<String, dynamic>)
    ..tontine = json['tontine'] == null
        ? null
        : Type_acc.fromJson(json['tontine'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AccountToJson(Account instance) =>
    <String, dynamic>{'epargne': instance.epargne, 'tontine': instance.tontine};
