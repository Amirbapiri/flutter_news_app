import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:news_app/consts/enums.dart';
import 'package:news_app/screens/home_screen/widgets/article_shimmer_effect.dart';
import 'package:shimmer/shimmer.dart';

import '../../../services/utils.dart';
import 'top_trending_loading.dart';

class NewsCardLoading extends StatefulWidget {
  const NewsCardLoading({
    Key? key,
    required this.newsTabType,
  }) : super(key: key);

  final NewsTabType newsTabType;

  @override
  State<NewsCardLoading> createState() => _NewsCardLoadingState();
}

class _NewsCardLoadingState extends State<NewsCardLoading> {
  late Color baseShimmerColor, highlightShimmerColor, widgetShimmerColor;

  @override
  void didChangeDependencies() {
    final Utils utils = Utils(context);
    baseShimmerColor = utils.baseShimmerColor;
    highlightShimmerColor = utils.highlightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (widget.newsTabType == NewsTabType.trending) {
      return Swiper(
        viewportFraction: 0.9,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.9,
        itemCount: 10,
        itemBuilder: (context, index) {
          return TopTrendingLoading(
              baseShimmerColor: baseShimmerColor,
              highlightShimmerColor: highlightShimmerColor,
              widgetShimmerColor: widgetShimmerColor,
              size: size);
        },
      );
    } else {
      return ArticleShimmerEffect(
          size: size,
          baseShimmerColor: baseShimmerColor,
          highlightShimmerColor: highlightShimmerColor,
          widgetShimmerColor: widgetShimmerColor);
    }
  }
}
