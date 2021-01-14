import 'package:json_annotation/json_annotation.dart';

part 'microfinance.g.dart';

@JsonSerializable()
class Microfinance {
  // Microfinance();

  num id;
  String name;
  String rccm;
  String nif;
  String address;
  String slogan;
  String tel;
  String ceo_name;
  String stamp;
  String world_countries_id;
  String world_cities_id;
  String zip;
  String size;
  String company_email;
  String logo;
  String register_on;
  num created_at;
  num updated_at;

  Microfinance({
    this.id,
    this.name,
    this.rccm,
    this.nif,
    this.address,
    this.slogan,
    this.tel,
    this.ceo_name,
    this.stamp,
    this.world_countries_id,
    this.world_cities_id,
    this.zip,
    this.size,
    this.company_email,
    this.logo,
    this.register_on,
    this.created_at,
    this.updated_at,
  });

  factory Microfinance.fromJson(Map<String, dynamic> json) =>
      _$MicrofinanceFromJson(json);
  Map<String, dynamic> toJson() => _$MicrofinanceToJson(this);
}
