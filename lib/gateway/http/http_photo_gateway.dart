import 'package:dio/dio.dart';
import 'package:gallery_for_lena/app/resources/app_config.dart';
import 'package:gallery_for_lena/app/resources/app_keys.dart';
import 'package:gallery_for_lena/domain/entity/photo_entity.dart';
import 'package:gallery_for_lena/domain/enum/type_photo.dart';
import 'package:gallery_for_lena/domain/gateway/photo_gateway.dart';

class HttpPhotoGateway extends PhotoGateway {
  final Dio dio = Dio();
  final TypePhoto typePhoto;

  HttpPhotoGateway(this.typePhoto);

  @override
  Future<List<PhotoEntity>> fetchPhoto() async {
    List<PhotoEntity> photos = [];

    final String url = "${AppConfig.baseUrl}/${AppKeys.photos}";

    final queryParameters = {
      AppConfig.queryParametersPage: page,
      AppConfig.queryParametersLimit: limit,
      _getTypePhoto(): true,
    };
    final response = await dio.get(url, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];

      photos = data.map((e) => PhotoEntity.fromJson(e)).cast<PhotoEntity>().toList();
    }

    return photos;
  }

  String _getTypePhoto() {
    switch (typePhoto) {
      case TypePhoto.NEW:
        return AppKeys.newType;
      case TypePhoto.POPULAR:
        return AppKeys.popularType;
      default:
        return '';
    }
  }
}
