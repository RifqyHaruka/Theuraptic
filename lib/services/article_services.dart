import 'dart:convert';

import 'package:haldac/model/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleService {
  var baseUrl = 'http://therapeutic.sakataguna-dev.com/public/api';

  Future<List<ArticleModel>> getArticle(String token) async {
    var url = Uri.parse('$baseUrl/article');
    var headers = {'Accept': 'application/json', 'Authorization': token};

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['article'];
      List<ArticleModel> article = [];

      for (var item in data) {
        article.add(ArticleModel.fromJson(item));
      }

      return article;
    } else {
      throw Exception('print Salah get artikel di service');
    }
  }

  Future<ArticleModel> getArticlebyId(String token, int id) async {
    var url = Uri.parse('$baseUrl/article?id=$id');
    var headers = {'Accept': 'application/json', 'Authorization': token};
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ArticleModel articleModel = ArticleModel.fromJson(data);
      return articleModel;
    } else {
      throw Exception('Salah get article by id di service');
    }
  }
}
