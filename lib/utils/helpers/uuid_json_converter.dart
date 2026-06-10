import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

class UuidJsonConverter implements JsonConverter<UuidValue, String> {
  const UuidJsonConverter();

  @override
  UuidValue fromJson(String json) {
    return UuidValue.fromString(json);
  }

  @override
  String toJson(UuidValue uuid) {
    return uuid.toString();
  }
}
