import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_for_lena/app/ui/scenes/gallery/bloc/gallery_bloc.dart';
import 'package:gallery_for_lena/domain/entity/photo_entity.dart';

// ignore: must_be_immutable
class ListPhoto extends StatelessWidget {
  ListPhoto({Key key, this.photos, this.isLoadingPagination = false}) : super(key: key);
  final List<PhotoEntity> photos;
  final bool isLoadingPagination;

  ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 100.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView(
          controller: _scrollController
            ..addListener(() {
              final maxScroll = _scrollController.position.maxScrollExtent;
              final currentScroll = _scrollController.offset;

              if (maxScroll - currentScroll <= _scrollThreshold &&
                  !isLoadingPagination &&
                  !_scrollController.position.outOfRange) {
                context.read<GalleryBloc>().add(GalleryFetch());
              }
            }),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
          children: List.generate(photos.length, (index) => _buildItemPhoto(photos[index])),
        ),
        if (isLoadingPagination)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              child: const Center(
                child: const CircularProgressIndicator(),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildItemPhoto(PhotoEntity photo) {
    return CachedNetworkImage(
      imageUrl: photo.getImageUrl(),
      placeholder: (context, url) => const Center(child: const CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
