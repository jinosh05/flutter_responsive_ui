import "package:extended_image/extended_image.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class AppImage extends StatelessWidget {
  const AppImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.package,
  });
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final String? package;

  @override
  Widget build(BuildContext context) {
    final isSvgImage = imageUrl.split(".").last == "svg";

    if (imageUrl.isEmpty) {
      return const SizedBox();
    }

    if (!imageUrl.contains("http")) {
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
            return const SizedBox();
          case LoadState.failed:
            return const SizedBox();
        }
      },
    );
  }
}
