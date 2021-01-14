// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'microfinance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Microfinance _$MicrofinanceFromJson(Map<String, dynamic> json) {
  return Microfinance()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..rccm = json['rccm'] as String
    ..nif = json['nif'] as String
    ..address = json['address'] as String
    ..slogan = json['slogan'] as String
    ..tel = json['tel'] as String
    ..ceo_name = json['ceo_name'] as String
    ..stamp = json['stamp'] as String
    ..world_countries_id = json['world_countries_id'] as String
    ..world_cities_id = json['world_cities_id'] as String
    ..zip = json['zip'] as String
    ..size = json['size'] as String
    ..company_email = json['company_email'] as String
    ..logo = json['logo'] as String
    ..register_on = json['register_on'] as String
    ..created_at = json['created_at'] as num
    ..updated_at = json['updated_at'] as num;
}

Map<String, dynamic> _$MicrofinanceToJson(Microfinance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rccm': instance.rccm,
      'nif': instance.nif,
      'address': instance.address,
      'slogan': instance.slogan,
      'tel': instance.tel,
      'ceo_name': instance.ceo_name,
      'stamp': instance.stamp,
      'world_countries_id': instance.world_countries_id,
      'world_cities_id': instance.world_cities_id,
      'zip': instance.zip,
      'size': instance.size,
      'company_email': instance.company_email,
      'logo': instance.logo,
      'register_on': instance.register_on,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at
    };
