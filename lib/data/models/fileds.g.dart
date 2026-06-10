// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressInfo _$AddressInfoFromJson(Map<String, dynamic> json) => AddressInfo(
  region: json['region'] as String,
  zone: json['zone'] as String,
  city: json['city'] as String,
  kebeleNo: json['kebele_no'] as String,
);

Map<String, dynamic> _$AddressInfoToJson(AddressInfo instance) =>
    <String, dynamic>{
      'region': instance.region,
      'zone': instance.zone,
      'city': instance.city,
      'kebele_no': instance.kebeleNo,
    };

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
  phone: json['phone'] as String,
  email: json['email'] as String,
  website: json['website'] as String,
);

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'phone': instance.phone,
  'email': instance.email,
  'website': instance.website,
};
