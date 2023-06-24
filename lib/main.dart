import 'package:flutter/material.dart';
import 'package:flutter_application_pw7/animations/animation_options.dart';
import 'package:flutter_application_pw7/screens/home.dart';
import 'package:flutter_application_pw7/screens/artists.dart';
import 'package:flutter_application_pw7/screens/not_found.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
      initialRoute: '/',
      onUnknownRoute: ((settings) => animateRoute(const NotFoundPage(), '')),
      onGenerateRoute: (settings) => switch (settings.name) {
        HomePage.routeName => animateRoute(const HomePage(), 'scale'),
        //MaterialPageRoute(builder: (context) => const HomePage()),
        ArtistsPage.routeName => animateRoute(const ArtistsPage(), 'scaleFade'),
        //MaterialPageRoute(builder: (context) => const ArtistsPage()),
        _ => animateRoute(const NotFoundPage(), ''),
        //MaterialPageRoute(builder: (context) => const NotFoundPage()),
      },
    );
  }
}
