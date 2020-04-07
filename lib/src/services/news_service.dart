import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _url_news = 'https://newsapi.org/v2';
final _apiKey = '9d8ef3097a47409595e16a6ff781caea';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertaiment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Articles>> categoryArticles = [];

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((item){
      this.categoryArticles[item.name] => new List();
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory (String valor) {
    this.selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListener();
  }

  List<Article> getArticulosCategoriaSeleccionada => this.categoryArticles[this._selectedCategory];

  getTopHeadlines() async {
    final url = '${_url_news}/top-headlines?apiKey=${_apiKey}&country=ve';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListener();
  }

  getArticlesByCategory(String category) async {

    if(this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }
    final url = '${_url_news}/top-headlines?apiKey=${_apiKey}&country=ve&category=${category}';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponse.artilces);

    notifyListener();
  }

}
