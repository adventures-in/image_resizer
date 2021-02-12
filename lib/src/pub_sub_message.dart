import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'pub_sub_message.g.dart';

@JsonSerializable()
class PubSubMessage {
  final String data;
  final Map<String, String> attributes;
  final String messageId;
  final DateTime publishTime;

  Uint8List dataBytes() => base64Decode(data);

  PubSubMessage(this.data, this.messageId, this.publishTime, this.attributes);

  factory PubSubMessage.fromJson(Map<String, dynamic> json) =>
      _$PubSubMessageFromJson(json);

  Map<String, dynamic> toJson() => _$PubSubMessageToJson(this);
}
