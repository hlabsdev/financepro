import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

class Message {
  String type;
  String content;
  bool read;
  String date;
  num sender;
  num receiver;

  Message({
    this.type,
    this.content,
    this.read,
    this.date,
    this.sender,
    this.receiver,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
