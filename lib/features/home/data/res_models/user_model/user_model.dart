// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? gender,
    Name? name,
    Location? location,
    String? email,
    Login? login,
    Dob? dob,
    Dob? registered,
    String? phone,
    String? cell,
    Id? id,
    Picture? picture,
    String? nat,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

}

@freezed
class Dob with _$Dob {
  const factory Dob({
    DateTime? date,
    int? age,
  }) = _Dob;

  factory Dob.fromJson(Map<String, dynamic> json) => _$DobFromJson(json);
}

@freezed
class Id with _$Id {
  const factory Id({
    String? name,
    String? value,
  }) = _Id;

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    Street? street,
    String? city,
    String? state,
    String? country,
    dynamic postcode,
    Coordinates? coordinates,
    Timezone? timezone,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}

@freezed
class Coordinates with _$Coordinates {
  const factory Coordinates({
    String? latitude,
    String? longitude,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);
}

@freezed
class Street with _$Street {
  const factory Street({
    int? number,
    String? name,
  }) = _Street;

  factory Street.fromJson(Map<String, dynamic> json) => _$StreetFromJson(json);
}

@freezed
class Timezone with _$Timezone {
  const factory Timezone({
    String? offset,
    String? description,
  }) = _Timezone;

  factory Timezone.fromJson(Map<String, dynamic> json) => _$TimezoneFromJson(json);
}

@freezed
class Login with _$Login {
  const factory Login({
    String? uuid,
    String? username,
    String? password,
    String? salt,
    String? md5,
    String? sha1,
    String? sha256,
  }) = _Login;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}

@freezed
class Name with _$Name {
  const factory Name({
    String? title,
    String? first,
    String? last,
  }) = _Name;

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
}

@freezed
class Picture with _$Picture {
  const factory Picture({
    String? large,
    String? medium,
    String? thumbnail,
  }) = _Picture;

  factory Picture.fromJson(Map<String, dynamic> json) => _$PictureFromJson(json);
}
