import 'package:json_annotation/json_annotation.dart';
import 'event.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String body;

  String err;

  String event;

  bool isError;

  bool isForced;

  bool isInvalid;

  bool isLocal;

  bool isNative;

  bool isNoOp;

  String namespace;

  String room;

  bool setBinary;

  String wait;

  bool get isConnect => this.event == OnNamespaceConnect;

  bool get isDisconnect => this.event == OnNamespaceDisconnect;

  bool get isRoomJoin => this.event == OnRoomJoin;

  bool get isRoomLeft => this.event == OnRoomLeft;

  bool get isWait {
    if (this.wait.isEmpty) return false;

    if (this.wait.startsWith(waitIsConfirmationPrefix)) return true;

    return this.wait.startsWith(waitComesFromClientPrefix);
  }

  T unmarshal<T>() {
    // TODO: implement unmarshal
    throw UnimplementedError();
  }

  Message({
    this.body,
    this.err,
    this.event,
    this.isError,
    this.isForced,
    this.isInvalid,
    this.isLocal,
    this.isNative,
    this.isNoOp,
    this.namespace,
    this.room,
    this.setBinary,
    this.wait,
  });

  /// Create a new instance from a json
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// Serialize to json
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}