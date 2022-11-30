import 'dart:convert';

import 'package:http/http.dart' as http;
import '../consts/http_exception.dart';
import '../models/news_model.dart';
import '../consts/api_consts.dart';

class NewsAPIServices {
  static Future<List<NewsModel>> getAllNews(
      {required int page, required String sortBy}) async {
    try {
      final uri = Uri.https(baseURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "page": page.toString(),
        "sortBy": sortBy,
      });
      final response = await http.get(uri, headers: {
        "X-Api-key": apiKey,
      });
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data["code"] != null) {
        throw HttpException(data["code"]);
      }
      for (var article in data["articles"]) {
        newsTempList.add(article);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<NewsModel>> getTopHeadlines() async {
    try {
      final uri = Uri.https(baseURL, "v2/top-headlines", {
        "country": "us",
      });
      final response = await http.get(uri, headers: {
        "X-Api-key": apiKey,
      });
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data["code"] != null) {
        throw HttpException(data["code"]);
      }
      for (var article in data["articles"]) {
        newsTempList.add(article);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<NewsModel>> searchNews(
      {required String query}) async {
    try {
      final uri = Uri.https(baseURL, "v2/everything", {
        "q": query,
        "pageSize": "10",
      });
      final response = await http.get(uri, headers: {
        "X-Api-key": apiKey,
      });
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data["code"] != null) {
        throw HttpException(data["code"]);
      }
      for (var article in data["articles"]) {
        newsTempList.add(article);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (e) {
      throw e.toString();
    }
  }
}
