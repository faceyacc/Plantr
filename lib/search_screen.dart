import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:http/http.dart' as http;

import 'NewPageSearch.dart';

class Post {
  final String commonName;
  final String scientificName;
  final String url;

  Post(this.commonName, this.scientificName, this.url);
}

class SearchScreen extends StatelessWidget {
  Future<List<Post>> search(String search) async {
    final List<Post> items = [];

    final http.Response response = await http.get(
        'https://trefle.io/api/v1/plants/search?token=UAm5i477Wb7rC5l8XB-DgFwtjiuawg-kpXGIpgxwiQk&q=$search');
    final Map<String, dynamic> responseData = json.decode(response.body);
    responseData['data'].forEach((post) {
      final Post postJson =
          Post(post['common_name'], post['scientific_name'], post['image_url']);

      items.add(postJson);
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<Post>(
            onSearch: search,
            onItemFound: (Post post, int index) {
              return ListTile(
                title: Text(post.commonName),
                subtitle: Text(post.scientificName),
                leading: Container(
                  constraints: BoxConstraints.tightFor(width: 120.0),
                  child: post.url == null
                      ? null
                      : Image.network(post.url, fit: BoxFit.fitWidth),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewPage(post);
                  }));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
