import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  int id;
  String firstname;
  String lastname;
  int creditcard;
  String email;
  int postal;
  String adresse;
  String login;
  String password;
  String token;
  bool status;

  Client(
      this.id,
      this.firstname,
      this.lastname,
      this.creditcard,
      this.email,
      this.postal,
      this.adresse,
      this.login,
      this.password,
      this.token,
      this.status);

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
