import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final String? package;

  const AppImage({
    required this.imageUrl,
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.package,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSvgImage = imageUrl.split('.').last == 'svg';

    if (imageUrl.isEmpty) {
      return const SizedBox();
    }

    if (!imageUrl.contains('http')) {
      if (isSvgImage) {
        return SvgPicture.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          package: package,
        );
      }

      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        package: package,
      );
    }

    if (isSvgImage) {
      return SvgPicture.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
    }

    return ExtendedImage.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.loading:
          case LoadState.failed:
          default:
            return const SizedBox();
        }
      },
    );
  }
}
