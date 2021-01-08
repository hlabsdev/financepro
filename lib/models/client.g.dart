// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) {
  return Client()
    ..id = json['id'] as num
    ..fname = json['fname'] as String
    ..lname = json['lname'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..world_countries_id = json['world_countries_id'] as String
    ..card_number = json['card_number'] as String
    ..card_type = json['card_type'] as String
    ..world_cities_id = json['world_cities_id'] as String
    ..type_user_id = json['type_user_id'] as String
    ..company_id = json['company_id'] as String
    ..profession = json['profession'] as String
    ..zone_id = json['zone_id'] as String
    ..birth_date = json['birth_date'] as String
    ..email_verified_at = json['email_verified_at'] as String
    ..guichet_number = json['guichet_number'] as num
    ..isActive = json['isActive'] as String
    ..company_branch_id = json['company_branch_id'] as String
    ..current_team_id = json['current_team_id'] as String
    ..profile_photo_path = json['profile_photo_path'] as String
    ..situation = json['situation'] as String
    ..beneficiaire = json['beneficiaire'] as String
    ..epoux = json['epoux'] as String
    ..reference = json['reference'] as String
    ..address = json['address'] as String
    ..isEnterprise = json['isEnterprise'] as String
    ..job_title_id = json['job_title_id'] as num
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..profile_photo_url = json['profile_photo_url'] as String;
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'phone': instance.phone,
      'world_countries_id': instance.world_countries_id,
      'card_number': instance.card_number,
      'card_type': instance.card_type,
      'world_cities_id': instance.world_cities_id,
      'type_user_id': instance.type_user_id,
      'company_id': instance.company_id,
      'profession': instance.profession,
      'zone_id': instance.zone_id,
      'birth_date': instance.birth_date,
      'email_verified_at': instance.email_verified_at,
      'guichet_number': instance.guichet_number,
      'isActive': instance.isActive,
      'company_branch_id': instance.company_branch_id,
      'current_team_id': instance.current_team_id,
      'profile_photo_path': instance.profile_photo_path,
      'situation': instance.situation,
      'beneficiaire': instance.beneficiaire,
      'epoux': instance.epoux,
      'reference': instance.reference,
      'address': instance.address,
      'isEnterprise': instance.isEnterprise,
      'job_title_id': instance.job_title_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'profile_photo_url': instance.profile_photo_url
    };
