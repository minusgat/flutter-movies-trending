import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'rounded_container.dart';

class RoundedImage extends StatelessWidget {
  final String? url;
  final String? img;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;

  const RoundedImage({
    Key? key,
    this.url,
    this.img,
    this.height,
    this.width,
    this.radius,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return width == null
        ? buildClipRRect()
        : Container(
            height: height,
            width: width,
            child: buildClipRRect(),
          );
  }

  Widget buildClipRRect() {
    return RoundedContainer(
      child: url == null
          ? Image.asset("$img", fit: fit ?? BoxFit.cover)
          : CachedNetworkImage(
              imageUrl: url ?? 'https://picsum.photos/250?image=9',
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                fit: fit ?? BoxFit.fill,
              ),
            ),
    );
  }
}
