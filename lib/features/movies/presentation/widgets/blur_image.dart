import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlurredImage extends StatelessWidget {
  final String? url;
  final String? imageAsset;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;

  const BlurredImage(
      {Key? key,
      this.url,
      this.imageAsset,
      this.height,
      this.width,
      this.radius,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return width == null
        ? buildBlurredImage()
        : Container(
            height: height,
            width: width,
            child: buildBlurredImage(),
          );
  }

  Widget buildBlurredImage() {
    return Stack(
      children: [
        Positioned.fill(
          child: buildBackgroundImage(),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 64, sigmaY: 24, tileMode: TileMode.mirror),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBackgroundImage() {
    return url == null
        ? Image.asset("$imageAsset", fit: fit ?? BoxFit.cover)
        : CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 500),
            imageUrl: url ?? 'https://picsum.photos/250?image=9',
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          );
  }
}
