import 'package:flutter/material.dart';
import 'package:flutter_application_pw7/widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
