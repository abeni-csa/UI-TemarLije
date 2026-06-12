import 'dart:convert';

import 'package:ui_temarlije/data/models/fileds.dart';

class Location {
  final String region;
  final String zone;
  final String city;
  final String kebeleNo;

  Location({
    required this.region,
    required this.zone,
    required this.city,
    required this.kebeleNo,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    region: json['region'] ?? '',
    zone: json['zone'] ?? '',
    city: json['city'] ?? '',
    kebeleNo: json['kebele_no'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'region': region,
    'zone': zone,
    'city': city,
    'kebele_no': kebeleNo,
  };
}

class School {
  final String schoolName;
  final Location location;
  final Location address;
  final Contact contact;
  final int establishedYear;
  final String schoolType;

  School({
    required this.schoolName,
    required this.location,
    required this.address,
    required this.contact,
    required this.establishedYear,
    required this.schoolType,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
    schoolName: json['school_name'] ?? '',
    location: Location.fromJson(json['location'] ?? {}),
    address: Location.fromJson(json['address'] ?? {}),
    contact: Contact.fromJson(json['contact'] ?? {}),
    establishedYear: json['established_year'] is int
        ? json['established_year']
        : int.tryParse('${json['established_year']}') ?? 0,
    schoolType: json['school_type'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'school_name': schoolName,
    'location': location.toJson(),
    'address': address.toJson(),
    'contact': contact.toJson(),
    'established_year': establishedYear,
    'school_type': schoolType,
  };

  String toEncodedJson() => jsonEncode(toJson());
}
