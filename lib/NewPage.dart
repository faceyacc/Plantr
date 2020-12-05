import 'package:flutter/material.dart';
import 'package:plantrapp/home_screen.dart';

class NewPage extends StatelessWidget {
  final Album album;
  NewPage(this.album);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plantr'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _renderBody(context, album),
      ),
    );
  }

  // Below deals with UI.

  List<Widget> _renderBody(BuildContext context, Album album) {
    var result = List<Widget>();
    result.add(_bannerImage(album.url, 170.00));
    result.addAll(_renderInfo(context, album));
    return result;
  }

  List<Widget> _renderInfo(BuildContext context, Album album) {
    var result = List<Widget>();
    result.add(_sectionTitle(album.commonName));
    result.add(_sectionText(album.scientificName));
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
        child: Text(text, textAlign: TextAlign.left));
  }

  Widget _sectionText(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
        child: Text(text));
  }

  Widget _bannerImage(String url, double height) {
    return Container(
        constraints: BoxConstraints.tightFor(height: height),
        child: Image.network(url, fit: BoxFit.fitWidth));
  }
}
