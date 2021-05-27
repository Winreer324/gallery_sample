import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gallery_for_lena/domain/entity/photo_entity.dart';
import 'package:gallery_for_lena/domain/gateway/photo_gateway.dart';
import 'package:meta/meta.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc(this.photoGateway) : super(GalleryInitial());
  final PhotoGateway photoGateway;

  @override
  Stream<GalleryState> mapEventToState(
    GalleryEvent event,
  ) async* {
    final currentState = state;
    try {
      if (event is GalleryFetch) {
        if (currentState is GallerySuccess) {
          if (currentState.photos.isNotEmpty) {
            yield GallerySuccess(currentState.photos, isLoadingPagination: true);
          }
        } else {
          yield GalleryLoading();
        }
        List<PhotoEntity> photos = [];
        photos = await photoGateway.fetchPhoto();

        if (photos.isNotEmpty) {
          photoGateway.incrementPage();
        }

        if (currentState is GallerySuccess) {
          final allPhotos = currentState.photos;
          allPhotos.addAll(photos);
          yield GallerySuccess(allPhotos);
        } else {
          yield GallerySuccess(photos);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
