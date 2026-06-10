import 'package:json_annotation/json_annotation.dart';
part 'fileds.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class AddressInfo {
  final String region;
  final String zone;
  final String city;
  final String kebeleNo;

  AddressInfo({
    required this.region,
    required this.zone,
    required this.city,
    required this.kebeleNo,
  });

  String get fullAddress => '$kebeleNo, $city, $zone, $region';
  // JSON serialization
  factory AddressInfo.fromJson(Map<String, dynamic> json) =>
      _$AddressInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInfoToJson(this);

  // SQLite mapping
  Map<String, dynamic> toMap() => toJson();
  factory AddressInfo.fromMap(Map<String, dynamic> map) =>
      _$AddressInfoFromJson(map);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: true)
class Contact {
  final String phone;
  final String email;
  final String website;

  Contact({required this.phone, required this.email, required this.website});

  // JSON serialization
  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);

  // SQLite mapping
  Map<String, dynamic> toMap() => toJson();
  factory Contact.fromMap(Map<String, dynamic> map) => _$ContactFromJson(map);
}
