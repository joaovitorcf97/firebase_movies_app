import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/config/movies_app.dart';
import 'core/services/firebase/firebase_service.dart';

void main() async {
  await FirebaseService.init();
  await dotenv.load();
  runApp(const MoviesApp());
}
