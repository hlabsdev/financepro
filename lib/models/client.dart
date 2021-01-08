import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  // Client();

  num id;
  String fname;
  String lname;
  String email;
  String phone;
  String world_countries_id;
  String card_number;
  String card_type;
  String world_cities_id;
  String type_user_id;
  String company_id;
  String profession;
  String zone_id;
  String birth_date;
  String email_verified_at;
  num guichet_number;
  String isActive;
  String company_branch_id;
  String current_team_id;
  String profile_photo_path;
  String situation;
  String beneficiaire;
  String epoux;
  String reference;
  String address;
  String isEnterprise;
  num job_title_id;
  String created_at;
  String updated_at;
  String profile_photo_url;

  Client({
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.world_countries_id,
    this.card_number,
    this.card_type,
    this.world_cities_id,
    this.type_user_id,
    this.company_id,
    this.profession,
    this.zone_id,
    this.birth_date,
    this.email_verified_at,
    this.guichet_number,
    this.isActive,
    this.company_branch_id,
    this.current_team_id,
    this.profile_photo_path,
    this.situation,
    this.beneficiaire,
    this.epoux,
    this.reference,
    this.address,
    this.isEnterprise,
    this.job_title_id,
    this.created_at,
    this.updated_at,
    this.profile_photo_url,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
