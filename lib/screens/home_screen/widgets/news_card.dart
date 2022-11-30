import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../models/news_model.dart';
import '../../../providers/news_provider.dart';
import '../../../services/utils.dart';
import '../../../screens/news_detail_screen/news_details_screen.dart';
import '../../news_detail_screen/news_detail_web_view.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final newsModelProvider = Provider.of<NewsModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              NewsDetailsScreen.routeName,
              arguments: {
                "url": newsModelProvider.url!,
                "publishedAt": newsModelProvider.publishedAt!,
              },
            );
          },
          child: Stack(
            children: [
              Container(
                height: size.height * 0.1,
                width: size.height * 0.1,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: size.height * 0.1,
                  width: size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.16,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FancyShimmerImage(
                        width: size.height * 0.14,
                        height: size.height * 0.14,
                        boxFit: BoxFit.cover,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorWidget:
                            Image.asset("assets/images/empty_image.png"),
                        imageUrl: "${newsModelProvider.urlToImage}",
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "${newsModelProvider.title}",
                                  style: Utils.getMainTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 20.0,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(width: 3.0),
                                    Text(newsModelProvider.readingTimeText),
                                  ],
                                )
                              ],
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.link_sharp),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        NewsDetailWebView.routeName,
                                        arguments: {
                                          "url": newsModelProvider.url
                                        },
                                      );
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      newsModelProvider.dateToShow,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Utils.getMainTextStyle
                                          .copyWith(fontSize: 14.0),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
