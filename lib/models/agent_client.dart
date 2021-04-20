import 'package:json_annotation/json_annotation.dart';

import "type_acc.dart";
import 'client.dart';

part 'agent_client.g.dart';

@JsonSerializable()
class Agent_client {
  Type_acc account;
  Client agent;

  Agent_client({
    this.account,
    this.agent,
  });

  factory Agent_client.fromJson(Map<String, dynamic> json) =>
      _$Agent_clientFromJson(json);
  Map<String, dynamic> toJson() => _$Agent_clientToJson(this);
}
