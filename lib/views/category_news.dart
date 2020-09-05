import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_model.dart';

import 'article.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
 bool _loading = true;
  List<ArticleModel> articles = new List<ArticleModel>();

 @override
 void initState() {
   // TODO: implement initState
   super.initState();

   getNews();
 }

  getNews() async{
    NewsCategory news = NewsCategory();
    await news.getNews(widget.category);
    articles = news.news;
    // print(articles);
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Category: "),
          Text(
            widget.category,
            style: TextStyle(
                color: Colors.blue
            ),
          )
        ],
      ),
      elevation: 0.0,
    ),
      body: _loading ?
          Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
          :
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: ListView.builder(
              itemCount:   articles.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index){
                return BlogTile(
                  imageUrl: articles[index].urlToImage,
                  title: articles[index].title,
                  desc: articles[index].description,
                  url: articles[index].url,
                );
              }
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title , desc, url;
  BlogTile({@required this.imageUrl, @required this.title, @required  this.desc, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
              title: title,
            )
        ));
      } ,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(imageUrl: imageUrl)
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 10,),
                Text(desc ,
                  style: TextStyle(
                      color: Colors.grey[800]
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
