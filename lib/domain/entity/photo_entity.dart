import 'package:json_annotation/json_annotation.dart';

import 'image_entity.dart';

part 'photo_entity.g.dart';

@JsonSerializable()
class PhotoEntity {
  final int id;
  final String name;
  final String description;
  final bool newType;
  final bool popularType;
  final ImageEntity image;

  PhotoEntity(this.id, this.name, this.description, this.newType, this.popularType, this.image);

  factory PhotoEntity.fromJson(Map<String, dynamic> json) => _$PhotoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoEntityToJson(this);

  String getImageUrl() => 'http://gallery.dev.webant.ru/media/${image.name}';
}
