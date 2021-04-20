// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agent_client _$Agent_clientFromJson(Map<String, dynamic> json) {
  return Agent_client()
    ..account = json['account'] == null
        ? null
        : Type_acc.fromJson(json['account'] as Map<String, dynamic>)
    ..agent = json['agent'] == null
        ? null
        : Client.fromJson(json['agent'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Agent_clientToJson(Agent_client instance) =>
    <String, dynamic>{'account': instance.account, 'agent': instance.agent};
