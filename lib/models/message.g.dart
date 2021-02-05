// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..type = json['type'] as String
    ..content = json['content'] as String
    ..read = json['read'] as bool
    ..date = json['date'] as String
    ..sender = json['sender'] as num
    ..receiver = json['receiver'] as num;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'type': instance.type,
      'content': instance.content,
      'read': instance.read,
      'date': instance.date,
      'sender': instance.sender,
      'receiver': instance.receiver
    };
