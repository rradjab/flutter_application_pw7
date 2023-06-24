import 'package:flutter/material.dart';
import 'package:flutter_application_pw7/animations/animation_options.dart';
import 'package:flutter_application_pw7/fetch_file.dart';
import 'package:flutter_application_pw7/widgets/drawer_widget.dart';

class ArtistsPage extends StatefulWidget {
  static const routeName = '/artists';
  const ArtistsPage({super.key});

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: FutureBuilder<List<ArtistsClass>>(
        future: fetchFileFromAssets('assets/artists.json'),
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
            (!snapshot.hasData || snapshot.hasError)
                ? const Center(child: Text('no data'))
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(snapshot.data[index].name),
                        onLongPress: () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Link is: ${snapshot.data[index].link}'),
                        )),
                        onTap: () {
                          Navigator.of(context).push(
                            animateRoute(
                                ArtistAboutPage(
                                    aboutText: snapshot.data[index].about),
                                'rotate'),
                            //MaterialPageRoute(builder: (builder) => ArtistAboutPage(aboutText: snapshot.data[index].about)
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}

class ArtistAboutPage extends StatelessWidget {
  final String aboutText;
  const ArtistAboutPage({super.key, required this.aboutText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(aboutText)),
    );
  }
}
