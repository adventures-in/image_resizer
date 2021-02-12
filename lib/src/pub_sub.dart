import 'package:dartimageresize/src/pub_sub_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pub_sub.g.dart';

@JsonSerializable()
class PubSub {
  final PubSubMessage message;
  final String subscription;

  PubSub(this.message, this.subscription);

  factory PubSub.fromJson(Map<String, dynamic> json) => _$PubSubFromJson(json);

  Map<String, dynamic> toJson() => _$PubSubToJson(this);
}
