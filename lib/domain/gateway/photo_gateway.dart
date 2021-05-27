import 'dart:core';

import 'package:gallery_for_lena/domain/entity/photo_entity.dart';

abstract class PhotoGateway {
  int _page = 1;
  int _limit = 10;

  int get page => _page;

  int get limit => _limit;

  void incrementPage(){
    _page++;
  }

  void resetCountPage(){
    _page = 1;
  }

  Future<List<PhotoEntity>> fetchPhoto();
}