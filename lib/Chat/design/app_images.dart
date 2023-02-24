import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _ImageAssets extends AssetImage {
  const _ImageAssets(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const cancelIcon = _ImageAssets('cancel_icon.png');
  static const searchIcon = _ImageAssets('search_icon.png');
  static const ines = _ImageAssets('ines.jpg');
  static const groupIcon = _ImageAssets('groups_icon.svg');
  static const personIcon = _ImageAssets('person_icon.svg');
}
