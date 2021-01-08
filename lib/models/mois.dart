import 'package:json_annotation/json_annotation.dart';

part 'mois.g.dart';

@JsonSerializable()
class Mois {
  // Mois();

  num id;
  String account_id;
  num position;
  num year;
  num month;
  num mise;
  bool is_taken;
  num created_at;
  num updated_at;

  Mois({
    this.id,
    this.account_id,
    this.position,
    this.year,
    this.month,
    this.mise,
    this.is_taken,
    this.created_at,
    this.updated_at,
  });

  factory Mois.fromJson(Map<String, dynamic> json) => _$MoisFromJson(json);
  Map<String, dynamic> toJson() => _$MoisToJson(this);
}
