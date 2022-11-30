import 'package:flutter/cupertino.dart';

import '../models/news_model.dart';
import '../services/news_api.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList => newsList;

  Future<List<NewsModel>> fetchAllNews(
      {required int page, required String sortBy}) async {
    newsList = await NewsAPIServices.getAllNews(page: page, sortBy: sortBy);
    return newsList;
  }

  NewsModel findByDate({required String publishDate}) {
    return newsList.firstWhere((element) => element.publishedAt == publishDate);
  }

  Future<List<NewsModel>> searchNews({required String query}) async{
    List<NewsModel> news = await NewsAPIServices.searchNews(query: query);
    return news;
  }

  Future<List<NewsModel>> fetchTopHeadlines() async {
    newsList = await NewsAPIServices.getTopHeadlines();
    return newsList;
  }
}
