import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String _imagePath = 'assets/images';

class _ImageAssets extends AssetImage {
  const _ImageAssets(String fileName) : super('$_imagePath/$fileName');
}

class _ImageSvg extends SvgPicture {
  _ImageSvg(String fileName, Color color)
      : super.asset('$_imagePath/$fileName', color: color);
}

class AppImages {
  static const cancelIcon = _ImageAssets('cancel_icon.png');
  static const searchIcon = _ImageAssets('search_icon.png');
  static const ines = _ImageAssets('ines.jpg');
  static final personIcon =
      _ImageSvg('person_icon.svg', AppColors.primaryColorDark);
}
