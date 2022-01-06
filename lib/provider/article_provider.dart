import 'package:flutter/cupertino.dart';
import 'package:haldac/model/article_model.dart';
import 'package:haldac/services/article_services.dart';

class ArticleProvider with ChangeNotifier {
  List<ArticleModel> _article = [];
  ArticleModel? _articleId;
  List<ArticleModel> get article => _article;
  ArticleModel get articleId => _articleId as ArticleModel;

  set article(List<ArticleModel> article) {
    _article = article;
    notifyListeners();
  }

  set articleId(ArticleModel articleId) {
    _articleId = articleId;
    notifyListeners();
  }

  Future<bool> getAllArticle(String token) async {
    try {
      List<ArticleModel> article = await ArticleService().getArticle(token);
      _article = article;
      return true;
    } catch (e) {
      print(e);
      print('error di get all docter provider');
      return false;
    }
  }

  Future<bool> getArticlebyId(String token, int id) async {
    try {
      ArticleModel articleId = await ArticleService().getArticlebyId(token, id);
      _articleId = articleId;
      return true;
    } catch (e) {
      print(e);
      print('salah get article id di provider');
      return false;
    }
  }
}
