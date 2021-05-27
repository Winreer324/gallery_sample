import 'package:flutter/material.dart';
import 'package:practice_webant_gallery_app/app/ui/scenes/gallery/bloc/gallery_bloc.dart';
import 'package:practice_webant_gallery_app/app/widgets/list_photo.dart';
import 'package:practice_webant_gallery_app/domain/gateway/photo_gateway.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({
    Key key,
  }) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if (state is GalleryLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GallerySuccess) {
            return ListPhoto(
              photos: state.photos,
              isLoadingPagination: state.isLoadingPagination,
            );
          }
          return Container();
        },
      ),
    );
  }
}
