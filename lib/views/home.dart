import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/category_model.dart';
import 'package:news/helper/news.dart';
import 'package:news/views/article.dart';
import 'category_news.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  categories = getCategories();
    getNews();
  }
  getNews() async{
    News news = News();

    await news.getNews();
    articles = news.news;

    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("My"),
            Text(
              "News",
              style: TextStyle(
                color: Colors.blue
              ),
            )
          ],
        ),
        elevation: 0.0,
      ),

      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator()
        ),
      )
        : SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              //categories
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 7),
                height: 70,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                      );
                    },
                   itemCount: categories.length,
                ),
              ),
            //  News
              Container(
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
              )
            ],
          ),
      ),
        ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
            category: this.categoryName,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 7),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  height: 60 ,
                  fit: BoxFit.cover,)
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(

               borderRadius: BorderRadius.circular(6),
               color: Colors.black26
            ),
                width: 120, height: 60,
                child: Text(
                    categoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                )
            )

          ],
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
          elevation:10,
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


