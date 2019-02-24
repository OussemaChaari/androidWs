// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      json['idProd'] as int,
      json['nameProd'] as String,
      json['definition'] as String,
      json['desc'] as String,
      json['localization'] as String,
      json['image'] as String);
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'idProd': instance.idProd,
      'nameProd': instance.nameProd,
      'definition': instance.definition,
      'desc': instance.desc,
      'localization': instance.localization,
      'image': instance.image
    };
