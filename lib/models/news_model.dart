import 'package:flutter/cupertino.dart';
import 'package:reading_time/reading_time.dart';

import '../services/global_methods.dart';

class NewsModel with ChangeNotifier {
  String? sourceId;
  String? sourceName;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String dateToShow;
  String readingTimeText;

  NewsModel({
    this.sourceId,
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    required this.dateToShow,
    required this.readingTimeText,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final String title = json["title"] ?? "";
    final String content = json["content"] ?? "";
    final String description = json["description"] ?? "";

    final String dateToShow = json["publishedAt"] != null
        ? GlobalMethods.formattedDateText(json["publishedAt"])
        : "";

    return NewsModel(
      sourceId: json["source"]["id"],
      sourceName: json["source"]["name"],
      author: json["author"],
      title: title,
      description: description,
      url: json["url"],
      urlToImage: json["urlToImage"] ??
          "http://spaceflightnow.com/wp-content/uploads/2018/02/25254688767_b67e0bf2ac_k.jpg",
      content: content,
      publishedAt: "publishedDate",
      dateToShow: dateToShow,
      readingTimeText:
          readingTime(title + content + description).msg.toString(),
    );
  }

  static List<NewsModel> newsFromSnapshot(List newsSnapshot) {
    return newsSnapshot.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source']["id"] = sourceId;
    data['source']["name"] = sourceName;
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage ??
        "http://spaceflightnow.com/wp-content/uploads/2018/02/25254688767_b67e0bf2ac_k.jpg";
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }

  // @override
  // String toString() {
  //   return "NewsModel(id: $sourceId)";
  // }
}
