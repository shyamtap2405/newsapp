import 'package:flutter/cupertino.dart';

class Category {
  String categoryName;
  Category({this.categoryName});
}

class Categories with ChangeNotifier {
  List<Category> category = [
    Category(categoryName: 'Top Headlines'),
    Category(categoryName: 'Technology'),
    Category(categoryName: 'Sports'),
    Category(categoryName: 'Business'),
    Category(categoryName: 'Education'),
    Category(categoryName: 'Entertainment'),
  ];

  List<Category> get categories {
    return [...category];
  }
}
