import 'package:finance/models/client.dart';
import 'package:json_annotation/json_annotation.dart';

import "type_acc.dart";

part 'agent_client.g.dart';

@JsonSerializable()
class AgentClient {
  Type_acc account;
  Client agent;

  AgentClient({
    this.account,
    this.agent,
  });

  factory AgentClient.fromJson(Map<String, dynamic> json) =>
      _$AgentClientFromJson(json);
  Map<String, dynamic> toJson() => _$AgentClientToJson(this);
}
