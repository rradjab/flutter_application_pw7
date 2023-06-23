import 'dart:convert';

import 'package:flutter/services.dart';

class ArtistsClass {
  String name;
  String link;
  String about;
  ArtistsClass({required this.name, required this.link, required this.about});
}

Future<List<ArtistsClass>> fetchFileFromAssets(String assetsPath) async {
  String text = await rootBundle.loadString(assetsPath).then((file) => file);
  var data = (json.decode(text) as List);
  return data
      .map((e) =>
          ArtistsClass(name: e['name'], link: e['link'], about: e['about']))
      .toList();
}
