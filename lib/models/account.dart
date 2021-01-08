import 'package:json_annotation/json_annotation.dart';

import "type_acc.dart";

part 'account.g.dart';

@JsonSerializable()
class Account {
  // Account();

  Type_acc epargne;
  Type_acc tontine;

  Account({
    this.epargne,
    this.tontine,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
