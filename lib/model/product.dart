import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  Product(this.idProd, this.nameProd, this.definition, this.desc,
      this.localization, this.image);

  int idProd;
  String nameProd;
  String definition;
  String desc;
  String localization;
  String image;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
