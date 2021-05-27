import 'dart:developer';

import 'package:practice_webant_gallery_app/app/resources/app_config.dart';
import 'package:practice_webant_gallery_app/app/resources/app_keys.dart';
import 'package:practice_webant_gallery_app/domain/entity/photo_entity.dart';
import 'package:practice_webant_gallery_app/domain/gateway/photo_gateway.dart';
import 'package:dio/dio.dart';

class NewPhotoGateway extends PhotoGateway {
  final Dio dio = Dio();

  @override
  Future<List<PhotoEntity>> fetchPhoto() async {
    List<PhotoEntity> photos = [];

    final String url = "${AppConfig.baseUrl}/${AppKeys.photos}";

    final queryParameters = {
      AppConfig.queryParametersPage: page,
      AppConfig.queryParametersLimit: limit,
      AppKeys.newType: true,
    };
    final response = await dio.get(url, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];

      photos = data.map((e) => PhotoEntity.fromJson(e)).cast<PhotoEntity>().toList();
    }

    return photos;
  }
}
