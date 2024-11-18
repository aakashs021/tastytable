import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AuthImageWithShimmer extends StatefulWidget {
  final String assetImage;

  const AuthImageWithShimmer({super.key, required this.assetImage});

  @override
  State<AuthImageWithShimmer> createState()=> _AuthImageWithShimmerState();
}

class _AuthImageWithShimmerState extends State<AuthImageWithShimmer> {
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
            (ImageInfo info, bool synchronousCall) {
              setState(() {
                _isImageLoaded = true;
              });
            },
            onError: (exception, stackTrace) {
              setState(() {
                _isImageLoaded =
                    true; 
              });
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return _isImageLoaded
        ? Image.asset(widget.assetImage)
        : Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: const EdgeInsets.all(60),
              width: 200,
              height: 350,
              child: const CircleAvatar(),
            ),
          );
  }
}
