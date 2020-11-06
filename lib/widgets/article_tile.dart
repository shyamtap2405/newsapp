import 'package:flutter/material.dart';
import 'package:newsapp/widgets/article_view.dart';

class ArticleTile extends StatelessWidget {
  final String url, title, desc,postUrl;

  const ArticleTile({ this.url, this.title, this.desc,this.postUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              postUrl: postUrl,
            )
        ));
      },
          child: Container(
        margin: EdgeInsets.only(top: 16),
          child: Card(
            
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
        children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FadeInImage(image: NetworkImage(url),fit: BoxFit.cover,placeholder: AssetImage('assets/images/newspaper.jpg'),),
            ),
            SizedBox(height: 8,),
            Text(title,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 18),),
            SizedBox(height: 8,),
            Text(desc,style: TextStyle(color: Colors.black54),)

        ],
      ),
                    ),
          )),
    );
  }
}
