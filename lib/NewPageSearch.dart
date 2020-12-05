import 'package:flutter/material.dart';
import 'package:plantrapp/search_screen.dart';

class NewPage extends StatelessWidget {
  final Post post;
  NewPage(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plantr'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _renderBody(context, post),
      ),
    );
  }

  // Below deals with UI.

  List<Widget> _renderBody(BuildContext context, Post post) {
    var result = List<Widget>();
    result.add(_bannerImage(post.url, 170.00));
    result.addAll(_renderInfo(context, post));
    return result;
  }

  List<Widget> _renderInfo(BuildContext context, Post post) {
    var result = List<Widget>();
    result.add(_sectionTitle(post.commonName));
    result.add(_sectionText(post.scientificName));
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
