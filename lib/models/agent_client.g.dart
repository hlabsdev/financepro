// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgentClient _$AgentClientFromJson(Map<String, dynamic> json) {
  return AgentClient()
    ..account = json['account'] == null
        ? null
        : Type_acc.fromJson(json['account'] as Map<String, dynamic>)
    ..agent = json['agent'] as String;
}

Map<String, dynamic> _$AgentClientToJson(AgentClient instance) =>
    <String, dynamic>{'account': instance.account, 'tontine': instance.agent};
