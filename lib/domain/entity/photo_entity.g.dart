// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoEntity _$PhotoEntityFromJson(Map<String, dynamic> json) {
  return PhotoEntity(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['newType'] as bool,
    json['popularType'] as bool,
    ImageEntity.fromJson(json['image'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PhotoEntityToJson(PhotoEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'newType': instance.newType,
      'popularType': instance.popularType,
      'image': instance.image,
    };
