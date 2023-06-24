import 'package:flutter/material.dart';

int highLightedItemIndex = -1;
Map<String, String> mapItems = {'Home': '/home', 'Artists': '/artists'};

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
