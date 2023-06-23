import 'package:flutter/material.dart';
import 'package:flutter_application_pw7/fetch_file.dart';

Map<String, String> mapItems = {'Home': '/home', 'Artists': '/artists'};
int highLightedItemIndex = -1;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
      initialRoute: '/',
      onUnknownRoute: ((settings) =>
          MaterialPageRoute(builder: (context) => const NotFoundPage())),
      onGenerateRoute: (settings) => switch (settings.name) {
        HomePage.routeName =>
          MaterialPageRoute(builder: (context) => const HomePage()),
        ArtistsPage.routeName =>
          MaterialPageRoute(builder: (context) => const ArtistsPage()),
        _ => MaterialPageRoute(builder: (context) => const NotFoundPage()),
      },
    );
  }
}

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Page is\'nt found'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (builder) {
                            return ArtistAboutPage(
                                aboutText: snapshot.data[index].about);
                          }));
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

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DrawerHeader(
            child: CircleAvatar(
              radius: 60,
              foregroundImage: NetworkImage('https://picsum.photos/200'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mapItems.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                tileColor: index == highLightedItemIndex
                    ? Colors.blue
                    : Colors.transparent,
                title: Text(mapItems.keys.elementAt(index)),
                onTap: () {
                  setState(() {
                    highLightedItemIndex = index;
                  });
                  Navigator.of(context)
                      .pushNamed(mapItems.values.elementAt(index));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
