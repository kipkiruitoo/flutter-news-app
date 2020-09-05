import 'dart:convert';

import 'package:news/models/article_model.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news = [];


Future<void> getNews() async{
  String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=c0ee2cdd5c2248e8b81f669baed640ff";

  var response = await http.get(url);
  var jsonData = jsonDecode(response.body);
  // print(jsonData);
  if(jsonData['status'] == "ok"){
    jsonData["articles"].forEach((element){
      if(element["urlToImage"] != null && element["description"] != null) {
        ArticleModel articleModel = new ArticleModel(
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          content: element["content"],
          author: element["author"],
          publishedAt: DateTime.parse(element["publishedAt"]),
        );

        news.add(articleModel);
      }
    });

    }
  }
}
class NewsCategory{
  List<ArticleModel> news = [];


  Future<void> getNews(String category) async{
    String url = "http://newsapi.org/v2/top-headlines?country=gb&category=$category&apiKey=c0ee2cdd5c2248e8b81f669baed640ff";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    // print(jsonData);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
            publishedAt: DateTime.parse(element["publishedAt"]),
          );

          news.add(articleModel);
        }
      });

    }
  }
}