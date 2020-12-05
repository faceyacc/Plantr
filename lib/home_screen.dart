import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'NewPage.dart';

class Album {
// Represents an indiviual repsresentation of a
// plant's info

  final int year;
  final String scientificName;
  final String commonName;
  final String url;

  Album({this.commonName, this.scientificName, this.year, this.url});
}

class HomeScreen extends StatefulWidget {
  // HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Album> items = [];

  void fetchAlbum() async {
    final http.Response response = await http.get(
        'https://trefle.io/api/v1/plants?token=UAm5i477Wb7rC5l8XB-DgFwtjiuawg-kpXGIpgxwiQk');

    final Map<String, dynamic> responseData = json.decode(response.body);
    responseData['data'].forEach((album) {
      final Album albumJson = Album(
          year: album['year'],
          scientificName: album['scientific_name'],
          commonName: album['common_name'],
          url: album['image_url']);
      setState(() {
        items.add(albumJson);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plantr App")),
      body: ListView.builder(
          itemCount: this.items.length, itemBuilder: _listViewItemBuilder),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var plantDetails = this.items[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: _itemThumbnail(plantDetails),
      title: _itemTitle(plantDetails),
      subtitle: _subtitle(plantDetails),
      onTap: () {
        _navigationToplantDetails(context, plantDetails);
      },
    );
  }

  Widget _itemTitle(Album album) {
    return Text(album.scientificName);
  }

  Widget _subtitle(Album album) {
    return Text(album.commonName);
  }

  Widget _itemThumbnail(Album album) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 120.0),
      child: album.url == null
          ? null
          : Image.network(album.url, fit: BoxFit.fitWidth),
    );
  }

  void _navigationToplantDetails(BuildContext context, Album plantDetails) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewPage(plantDetails);
    }));
  }
}
