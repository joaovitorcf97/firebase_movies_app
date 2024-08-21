class AssetsPathsConst {
  static final AssetsPathsConst _singleton = AssetsPathsConst._internal();

  factory AssetsPathsConst() {
    return _singleton;
  }

  AssetsPathsConst._internal();

  static const _animationFolder = 'assets/animations';

  static String get animationSplash =>
      '$_animationFolder/34590-movie-theatre.json';

  static String get animationLogin =>
      '$_animationFolder/26406-clapperboard.json';

  static const String _imageFolder = 'assets/images';
  static String get cinemaImage => '$_imageFolder/cinema.jpg';
}
