// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    namespace: json['namespace'] as String,
    isLocal: json['isLocal'] as bool,
    event: json['event'] as String,
    wait: json['wait'] as String,
    room: json['room'] as String,
    err: json['err'] as String,
    isError: json['isError'] as bool,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'namespace': instance.namespace,
      'isLocal': instance.isLocal,
      'event': instance.event,
      'wait': instance.wait,
      'room': instance.room,
      'err': instance.err,
      'isError': instance.isError,
      'body': instance.body,
    };
