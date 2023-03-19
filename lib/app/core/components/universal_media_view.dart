import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../enum/enums.dart';
import '../utils/utils.dart';
import '../values/app_colors.dart';
import '../values/app_constants.dart';
import '../values/app_dimen.dart';
import 'custom_ink_well.dart';

class UniversalMediaView extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final String? path;
  final String? placeHolderPath;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit fit;
  final Widget? errorWidget;
  final Widget? placeHolder;
  final bool isImageRound;
  final bool isRepeat;
  final Function? onTap;
  final String id;
  final String? mediaTypeEnum;
  final Color? tintColor;
  final Color background;
  final Color borderColor;
  final bool isClickable;
  final BorderRadius? borderRadius;
  final BorderRadius? backgroundRadius;
  final bool useResizeImage;

  const UniversalMediaView({
    Key? key,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    required this.path,
    this.placeHolderPath,
    this.imageWidth,
    this.imageHeight,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.placeHolder,
    this.isImageRound = false,
    this.isRepeat = true,
    this.onTap,
    required this.id,
    this.mediaTypeEnum = '',
    this.tintColor,
    this.background = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.isClickable = false,
    this.borderRadius,
    this.backgroundRadius,
    this.useResizeImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isClickable
        ? CustomInkWell(
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
            id: id,
            child: Container(
              width: imageWidth,
              height: imageHeight,
              margin: margin,
              decoration: isImageRound
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: background,
                      border: Border.all(color: borderColor))
                  : BoxDecoration(color: background, borderRadius: backgroundRadius),
              child: Padding(
                  padding: padding,
                  child: ClipRRect(
                    borderRadius: borderRadius ??
                        BorderRadius.all(isImageRound
                            ? Radius.circular(imageHeight ?? 2 / 2)
                            : const Radius.circular(0.0)),
                    child: _getImageView(isCached: true, isHttpOnly: false),
                  )),
            ),
          )
        : Container(
            width: imageWidth,
            height: imageHeight,
            margin: margin,
            decoration: isImageRound
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: background,
                    border: Border.all(color: borderColor))
                : BoxDecoration(color: background, borderRadius: backgroundRadius),
            child: Padding(
                padding: padding,
                child: ClipRRect(
                  borderRadius: borderRadius ??
                      BorderRadius.all(isImageRound
                          ? Radius.circular(imageHeight ?? 2 / 2)
                          : const Radius.circular(0.0)),
                  child: _getImageView(isCached: true, isHttpOnly: false),
                )),
          );
  }

  Widget? _getImageView({bool isCached = true, bool isHttpOnly = false}) {
    MediaType imageType = getImageType(path ?? '');
    if (imageType == MediaType.NETWORK_IMAGE) {
      var url = isHttpOnly ? path ?? ''.replaceFirst('https', 'http') : path;
      // appLog("IMAGE_PATH U ===> $url");
      return !isCached
          ? Image.network(
              url ?? '',
              width: imageWidth,
              height: imageHeight,
              cacheHeight: useResizeImage && imageHeight != null ? imageHeight!.toInt() * AppConstants.multiplyCache : null,
              cacheWidth: useResizeImage && imageWidth != null ? imageWidth!.toInt() * AppConstants.multiplyCache : null,
              fit: fit,
              headers: const {
                "Connection": "Keep-Alive",
                "Keep-Alive": "timeout=5, max=1000"
              },
              errorBuilder: (context, error, stackTrace) =>
                  Container(child: errorHolderImage()),
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : placeHolderImage()!,
            )
          : CachedNetworkImage(
              imageUrl: url ?? '',
              width: imageWidth,
              height: imageHeight,
              memCacheHeight: useResizeImage && imageHeight != null ? imageHeight!.toInt() * AppConstants.multiplyCache : null,
              memCacheWidth: useResizeImage && imageWidth != null ? imageWidth!.toInt() * AppConstants.multiplyCache : null,
              maxHeightDiskCache: useResizeImage && imageHeight != null ? imageHeight!.toInt() * AppConstants.multiplyCache : null,
              maxWidthDiskCache: useResizeImage && imageWidth != null ? imageWidth!.toInt() * AppConstants.multiplyCache : null,
              fit: fit,
              errorWidget: (context, url, error) => Container(child: errorHolderImage()),
              placeholder: (context, url) => Container(child: placeHolderImage()),
            );
    } else if (imageType == MediaType.ASSET_IMAGE) {
      return Image.asset(
        path ?? '',
        width: imageWidth,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            Container(child: errorHolderImage()),
      );
    } else if (imageType == MediaType.NETWORK_SVG) {
      return SvgPicture.network(
        path ?? '',
        width: imageWidth,
        color: tintColor,
        fit: fit,
        placeholderBuilder: (BuildContext context) =>
            Container(child: placeHolderImage()),
      );
    } else if (imageType == MediaType.ASSET_SVG) {
      return SvgPicture.asset(
        path ?? '',
        color: tintColor,
        width: imageWidth,
        height: imageHeight,
        fit: fit,
        placeholderBuilder: (BuildContext context) =>
            Container(child: placeHolderImage()),
      );
    } else {
      return placeHolder ?? errorHolderImage();
    }
  }

  MediaType getImageType(String? path) {
    if (path != null && path.isNotEmpty) {
      if (isUrlCorrect(path) &&
          (mediaTypeEnum != null
              ? mediaTypeEnum!.isNotEmpty
              : mediaTypeEnum != null)) {
        if (mediaTypeEnum == "SVG") {
          return MediaType.NETWORK_SVG;
        } else if (mediaTypeEnum == "LOTTIE") {
          return MediaType.NETWORK_LOTTIE;
        } else if (mediaTypeEnum == "PNG") {
          return MediaType.NETWORK_IMAGE;
        } else if (mediaTypeEnum == "IMAGE") {
          return MediaType.NETWORK_IMAGE;
        } else {
          return MediaType.ERROR;
        }
      } else if (isUrlCorrect(path) &&
          (mediaTypeEnum != null
              ? mediaTypeEnum!.isEmpty
              : mediaTypeEnum == null)) {
        // Fallback in case imageTypeEnum is null from backend
        if (path.endsWith("svg")) {
          return MediaType.NETWORK_SVG;
        } else if (path.endsWith("json")) {
          return MediaType.NETWORK_LOTTIE;
        } else if (path.endsWith("png") ||
            path.endsWith("jpg") ||
            path.endsWith("jpeg") ||
            path.endsWith("gif")) {
          return MediaType.NETWORK_IMAGE;
        } else {
          return MediaType.ERROR;
        }
      } else {
        if (path.endsWith("svg")) {
          return MediaType.ASSET_SVG;
        } else if (path.endsWith("json")) {
          return MediaType.ASSET_LOTTIE;
        } else if (path.endsWith("png") ||
            path.endsWith("jpg") ||
            path.endsWith("jpeg") ||
            path.endsWith("gif")) {
          return MediaType.ASSET_IMAGE;
        } else {
          return MediaType.ERROR;
        }
      }
    } else {
      return MediaType.ERROR;
    }
  }

  Widget? placeHolderImage() {
    return placeHolderPath != null
        ? UniversalMediaView(
            path: placeHolderPath ?? '',
            imageWidth: imageWidth,
            imageHeight: imageHeight,
            fit: fit,
            id: '',
          )
        : placeHolder ??
            Container(
              height: imageHeight ?? spacingXXL10,
              width: imageWidth ?? spacingXXL10,
              color: white_100,
            );
  }

  Widget? errorHolderImage() {
    return placeHolderPath != null
        ? UniversalMediaView(
            path: placeHolderPath ?? '',
            imageWidth: imageWidth,
            imageHeight: imageHeight,
            fit: fit,
            id: '',
          )
        : errorWidget ??
            Container(
              height: imageHeight ?? spacingXXL10,
              width: imageWidth ?? spacingXXL10,
              color: primaryRed,
            );
  }
}
