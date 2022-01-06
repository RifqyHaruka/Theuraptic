import 'package:flutter/material.dart';
import 'package:haldac/model/article_model.dart';
import 'package:haldac/pages/info_kesehatan.dart';
import 'package:haldac/provider/article_provider.dart';
import 'package:haldac/provider/auth_provider.dart';
import 'package:haldac/theme.dart';
import 'package:provider/provider.dart';

class ArtikelCard extends StatefulWidget {
  final ArticleModel? articleModel;

  ArtikelCard(this.articleModel);

  @override
  State<ArtikelCard> createState() => _ArtikelCardState();
}

class _ArtikelCardState extends State<ArtikelCard> {
  @override
  Widget build(BuildContext context) {
    ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    articleDetailhandler() async {
      if (await articleProvider.getArticlebyId(
          authProvider.user.token as String, widget.articleModel!.id as int)) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoKesehatan()));
      }
    }

    return GestureDetector(
      onTap: () {
        articleDetailhandler();
      },
      child: Container(
          margin: EdgeInsets.only(top: 8, bottom: 10),
          width: 315,
          height: 82,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: putihButek),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/artikel1.png'),
                          fit: BoxFit.cover))),
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.articleModel!.title as String,
                        style: blackText.copyWith(
                            fontWeight: regular, fontSize: 10),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "22 Agustus 2021",
                        style: blackText.copyWith(
                            fontWeight: regular, fontSize: 8),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
