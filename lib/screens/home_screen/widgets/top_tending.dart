import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/news_model.dart';
import '../../../services/utils.dart';
import '../../news_detail_screen/news_detail_web_view.dart';
import '../../news_detail_screen/news_details_screen.dart';

class TopTrending extends StatelessWidget {
  const TopTrending({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color color = Utils(context).getColorForCurrentTheme;

    final newsModelProvider = Provider.of<NewsModel>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              NewsDetailsScreen.routeName,
              arguments: {"publishedAt": newsModelProvider.publishedAt!},
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FancyShimmerImage(
                      boxFit: BoxFit.fill,
                      errorWidget: Image.asset('assets/images/empty_image.png'),
                      imageUrl:
                          "${newsModelProvider.urlToImage}",
                      height: size.height * 0.33,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          NewsDetailWebView.routeName,
                          arguments: {"url": newsModelProvider.url!},
                        );
                      },
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.link,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${newsModelProvider.title}",
                  style: Utils.getMainTextStyle.copyWith(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${newsModelProvider.description}",
                      style: Utils.getMainTextStyle.copyWith(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Read in:",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: Utils.getMainTextStyle.copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 13),
                              ),
                              Text(
                                newsModelProvider.readingTimeText,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: Utils.getMainTextStyle.copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 13),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
