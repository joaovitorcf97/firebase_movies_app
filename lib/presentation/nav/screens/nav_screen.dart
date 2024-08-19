import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextWidget.title('Home Scren'),
      ),
    );
  }
}
