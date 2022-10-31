import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../widgets/rounded_close_button.dart';

enum ImageViewerType {
  url,
  urls,
  files,
  file,
}

class ImageViewerPageParams {
  final String? imageUrl;
  final File? imageFile;
  final List<String>? imageUrls;
  final List<File>? imageFiles;
  final ImageViewerType type;
  final int? initialPage;
  final String heroTag;
  ImageViewerPageParams({
    this.imageUrl,
    this.imageFile,
    this.imageUrls,
    this.imageFiles,
    required this.type,
    this.initialPage,
    required this.heroTag,
  });
}

class ImageViewerPage extends StatefulWidget {
  final ImageViewerPageParams params;
  const ImageViewerPage({
    super.key,
    required this.params,
  });

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  late final PageController pageCtr;
  @override
  void initState() {
    pageCtr = PageController(initialPage: widget.params.initialPage ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: widget.params.heroTag,
              child: displayImage(),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: RoundedCloseButton(
                iconSize: 24,
                padding: const EdgeInsets.all(10),
                onTap: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayImage() {
    switch (widget.params.type) {
      case ImageViewerType.url:
        if (widget.params.imageUrl == null) {
          throw Exception('[imageUrl] is required');
        }
        return PhotoView(
          imageProvider: NetworkImage(widget.params.imageUrl!),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          loadingBuilder: _imageLoader,
        );
      case ImageViewerType.file:
        if (widget.params.imageFile == null) {
          throw Exception('[imageFile] is required');
        }
        return PhotoView(
          imageProvider: FileImage(widget.params.imageFile!),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          loadingBuilder: _imageLoader,
        );
      case ImageViewerType.urls:
        if (widget.params.imageUrls == null) {
          throw Exception('[imageUrls] is required');
        }
        return PhotoViewGallery.builder(
          itemCount: widget.params.imageUrls?.length,
          pageController: pageCtr,
          loadingBuilder: _imageLoader,
          builder: (context, index) => PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.params.imageUrls![index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        );

      case ImageViewerType.files:
        if (widget.params.imageFiles == null) {
          throw Exception('[imageFiles] is required');
        }
        return PhotoViewGallery.builder(
          itemCount: widget.params.imageFiles?.length,
          pageController: pageCtr,
          loadingBuilder: _imageLoader,
          builder: (context, index) => PhotoViewGalleryPageOptions(
            imageProvider: FileImage(widget.params.imageFiles![index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        );
    }
  }

  Widget _imageLoader(
    BuildContext context,
    ImageChunkEvent? loadingProgress,
  ) {
    return const LoadingIndicator(
      color: Colors.white,
    );
  }
}
