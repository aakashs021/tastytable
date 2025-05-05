import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchImageLoaderShimmer extends StatefulWidget {
  final String assetImage;
  final double size;

  const SearchImageLoaderShimmer({
    super.key,
    required this.assetImage,
    this.size = 120, // Default size if not passed
  });

  @override
  State<SearchImageLoaderShimmer> createState() =>
      _SearchImageLoaderShimmerState();
}

class _SearchImageLoaderShimmerState extends State<SearchImageLoaderShimmer> {
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    final Image image = Image.asset(widget.assetImage);

    image.image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo info, bool _) {
              setState(() {
                _isImageLoaded = true;
              });
            },
            onError: (exception, stackTrace) {
              setState(() {
                _isImageLoaded = true; // Optionally handle error state
              });
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green),
        color: Colors.white,
      ),
      child: ClipOval(
        child: _isImageLoaded
            ? Image.asset(
                widget.assetImage,
                // fit: BoxFit.cover,
                width: widget.size,
                height: widget.size,
              )
            : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
