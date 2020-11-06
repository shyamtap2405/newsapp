import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/providers/news.dart';
import 'package:newsapp/widgets/article_view.dart';

class Search extends SearchDelegate {
  String get selectedResult => null;
  List<Article> _news = [];

  Future<void> _getNews() async {
    final url =
        "https://newsapi.org/v2/everything?q=$query&apiKey=6ed3a6f0bdeb4fa88ac2b3b7e78d838c";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          _news.add(article);
        }
      });
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
            _news = [];
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return _news.isEmpty && query.isEmpty? Container(): 
    FutureBuilder(
        future: _getNews(),
        builder: (context, snapshot) {
          print(_news[0].title);
          return _news.isEmpty? Container(): 
           ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleView(
                                    postUrl: _news[index].url,
                                  )));
                    },
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          height: 70,
                          width: 140,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                _news[index].urlToImage,
                                fit: BoxFit.cover,
                              )),
                        ),
                        title: Text(_news[index].title),
                        subtitle: Text(
                          _news[index].description,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ));

          // ignore: dead_code
          if (query.isEmpty) {
            return Container();
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _news.isEmpty && query.isEmpty ? Container(): FutureBuilder(
        future: _getNews(),
        builder: (context, snapshot) {
     
          return _news.isEmpty? Container(): 
          ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleView(
                                    postUrl: _news[index].url,
                                  )));
                    },
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          height: 70,
                          width: 140,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                _news[index].urlToImage,
                                fit: BoxFit.cover,
                              )),
                        ),
                        title: Text(_news[index].title),
                        subtitle: Text(
                          _news[index].description,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ));

          // ignore: dead_code
          if (query.isEmpty) {
            return Container();
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

