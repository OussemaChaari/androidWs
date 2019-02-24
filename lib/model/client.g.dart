// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) {
  return Client(
      json['id'] as int,
      json['firstname'] as String,
      json['lastname'] as String,
      json['creditcard'] as int,
      json['email'] as String,
      json['postal'] as int,
      json['adresse'] as String,
      json['login'] as String,
      json['password'] as String,
      json['token'] as String,
      json['status'] as bool);
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'creditcard': instance.creditcard,
      'email': instance.email,
      'postal': instance.postal,
      'adresse': instance.adresse,
      'login': instance.login,
      'password': instance.password,
      'token': instance.token,
      'status': instance.status
    };
