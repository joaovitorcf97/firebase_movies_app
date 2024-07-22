import 'package:provider/provider.dart';

import '../factories/api_repository_factory.dart';

class AppInitialBindings {
  static final AppInitialBindings _singleton = AppInitialBindings._internal();

  factory AppInitialBindings() {
    return _singleton;
  }

  AppInitialBindings._internal();

  static List<Provider> dependencies() {
    return [makeApiRepository];
  }
}
