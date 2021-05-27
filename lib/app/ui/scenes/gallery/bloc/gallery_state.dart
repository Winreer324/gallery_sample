part of 'gallery_bloc.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GallerySuccess extends GalleryState {
  final List<PhotoEntity> photos;
  final bool isLoadingPagination;

  GallerySuccess(this.photos, {this.isLoadingPagination = false});

  GallerySuccess copyWith(List<PhotoEntity> photos, bool isLoadingPagination) {
    return GallerySuccess(
      photos ?? this.photos,
      isLoadingPagination: isLoadingPagination ?? this.isLoadingPagination,
    );
  }
}
