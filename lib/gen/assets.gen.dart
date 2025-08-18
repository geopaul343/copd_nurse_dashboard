// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_app_logowithname.png
  AssetGenImage get imgAppLogowithname =>
      const AssetGenImage('assets/images/img_app_logowithname.png');

  /// File path: assets/images/img_bg_welcome.png
  AssetGenImage get imgBgWelcome =>
      const AssetGenImage('assets/images/img_bg_welcome.png');

  /// File path: assets/images/img_doctor_alexa.png
  AssetGenImage get imgDoctorAlexa =>
      const AssetGenImage('assets/images/img_doctor_alexa.png');

  /// File path: assets/images/img_splash.png
  AssetGenImage get imgSplash =>
      const AssetGenImage('assets/images/img_splash.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    imgAppLogowithname,
    imgBgWelcome,
    imgDoctorAlexa,
    imgSplash,
  ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/ic_arrow_back.svg
  SvgGenImage get icArrowBack =>
      const SvgGenImage('assets/svgs/ic_arrow_back.svg');

  /// File path: assets/svgs/ic_camera.svg
  SvgGenImage get icCamera => const SvgGenImage('assets/svgs/ic_camera.svg');

  /// File path: assets/svgs/ic_checked_circle.svg
  SvgGenImage get icCheckedCircle =>
      const SvgGenImage('assets/svgs/ic_checked_circle.svg');

  /// File path: assets/svgs/ic_checked_squre.svg
  SvgGenImage get icCheckedSqure =>
      const SvgGenImage('assets/svgs/ic_checked_squre.svg');

  /// File path: assets/svgs/ic_file_image_placeholder.svg
  SvgGenImage get icFileImagePlaceholder =>
      const SvgGenImage('assets/svgs/ic_file_image_placeholder.svg');

  /// File path: assets/svgs/ic_google_logo.svg
  SvgGenImage get icGoogleLogo =>
      const SvgGenImage('assets/svgs/ic_google_logo.svg');

  /// File path: assets/svgs/ic_orange_i.svg
  SvgGenImage get icOrangeI => const SvgGenImage('assets/svgs/ic_orange_i.svg');

  /// File path: assets/svgs/ic_register_top_bubble.svg
  SvgGenImage get icRegisterTopBubble =>
      const SvgGenImage('assets/svgs/ic_register_top_bubble.svg');

  /// File path: assets/svgs/ic_search.svg
  SvgGenImage get icSearch => const SvgGenImage('assets/svgs/ic_search.svg');

  /// File path: assets/svgs/ic_text_to_speak.svg
  SvgGenImage get icTextToSpeak =>
      const SvgGenImage('assets/svgs/ic_text_to_speak.svg');

  /// File path: assets/svgs/ic_trash.svg
  SvgGenImage get icTrash => const SvgGenImage('assets/svgs/ic_trash.svg');

  /// File path: assets/svgs/ic_uncheck_squre.svg
  SvgGenImage get icUncheckSqure =>
      const SvgGenImage('assets/svgs/ic_uncheck_squre.svg');

  /// File path: assets/svgs/ic_unchecked_circle.svg
  SvgGenImage get icUncheckedCircle =>
      const SvgGenImage('assets/svgs/ic_unchecked_circle.svg');

  /// File path: assets/svgs/ic_upload.svg
  SvgGenImage get icUpload => const SvgGenImage('assets/svgs/ic_upload.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    icArrowBack,
    icCamera,
    icCheckedCircle,
    icCheckedSqure,
    icFileImagePlaceholder,
    icGoogleLogo,
    icOrangeI,
    icRegisterTopBubble,
    icSearch,
    icTextToSpeak,
    icTrash,
    icUncheckSqure,
    icUncheckedCircle,
    icUpload,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
