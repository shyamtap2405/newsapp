import 'package:flutter/material.dart';
import 'package:newsapp/providers/category.dart';
import 'package:newsapp/providers/news.dart';
import 'package:newsapp/widgets/article_tile.dart';
import 'package:newsapp/widgets/category_item.dart';
import 'package:newsapp/widgets/search.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _isLoading = true;
  var newslist;

  void getNews() async {
    NewsReports news = NewsReports();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context).categories;
    // final news = Provider.of<NewsReports>(context).newsReports;

    return Scaffold(
      appBar: AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "News",
          style:
          TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        Text(
          "App",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        )
      ],
    ),
     actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: Search(

                    ));
              })
        ],
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height:40,
                    child: Center(
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) => GestureDetector(
                              onTap: () {
                                 Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            newsCategory: categories[index].categoryName.toLowerCase(),
          )
        ));
                              },
                              child: Row(
                                children: [
                                  Chip(backgroundColor: Colors.lightBlue,
                                      label: Text(categories[index].categoryName,style: TextStyle(color: Colors.white),)
                                      ),
                                      SizedBox(width: 8,)
                                ],
                              )
                                  )),
                    )),
                                Container(child:ListView.builder(itemCount: newslist.length,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                  itemBuilder: (ctx,i)=>ArticleTile(url: newslist[i].urlToImage,title: newslist[i].title,desc: newslist[i].description,postUrl: newslist[i].url,)))
                                ]

              ),
            )
            ),
    );
  }
}

