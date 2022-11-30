import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../consts/enums.dart';
import '../../models/news_model.dart';
import '../../providers/news_provider.dart';
import '../../services/news_api.dart';
import '../../services/utils.dart';
import '../search_screen/search_screen.dart';
import 'widgets/custom_tab.dart';
import 'widgets/news_card.dart';
import 'widgets/news_card_loading.dart';
import 'widgets/pagination_button.dart';
import 'widgets/top_tending.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsTabType newsTabType = NewsTabType.allNews;
  var currentPageNumber = 1;
  String sortBy = SortBy.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColorForCurrentTheme;
    final size = MediaQuery.of(context).size;
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: color),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "SlippyJimmy",
          style: GoogleFonts.lobster(color: color),
        ),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.search),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const SearchScreen(),
                    type: PageTransitionType.rightToLeft,
                    inheritTheme: true,
                    ctx: context),
              );
            },
          )
        ],
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTab(
                  title: "All news",
                  backgroundColor: newsTabType == NewsTabType.allNews
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  onTap: () {
                    if (newsTabType != NewsTabType.allNews) {
                      setState(() {
                        newsTabType = NewsTabType.allNews;
                      });
                    }
                  },
                  fontSize: newsTabType == NewsTabType.allNews ? 17.5 : 16.0,
                ),
                CustomTab(
                  title: "Trending",
                  backgroundColor: newsTabType == NewsTabType.trending
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  onTap: () {
                    if (newsTabType != NewsTabType.trending) {
                      setState(() {
                        newsTabType = NewsTabType.trending;
                      });
                    }
                  },
                  fontSize: newsTabType == NewsTabType.trending ? 17.5 : 16.0,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: newsTabType == NewsTabType.allNews
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: NewsPaginationButton(
                            icon: IconlyLight.arrowLeft,
                            onPressed: () {
                              if (currentPageNumber > 0) {
                                setState(() {
                                  currentPageNumber -= 1;
                                });
                              }
                            },
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  setState(() {
                                    currentPageNumber = index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: index == currentPageNumber
                                        ? Colors.blue
                                        : Theme.of(context).cardColor,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 2),
                                  padding: const EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    (index + 1).toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 13.0,
                                      color: index == currentPageNumber
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5.0),
                          child: NewsPaginationButton(
                            icon: IconlyLight.arrowRight,
                            onPressed: () {
                              // TODO: getting the end of pagination with data
                              if (currentPageNumber < newsProvider.getNewsList.length - 1) {
                                setState(() {
                                  currentPageNumber += 1;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            if (newsTabType == NewsTabType.allNews)
              Column(
                children: [
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: DropdownButton<String>(
                        elevation: 0,
                        style:
                            GoogleFonts.lato(fontSize: 15, color: Colors.black),
                        items: [
                          DropdownMenuItem(
                              value: SortBy.relevancy.name,
                              child: Text(
                                SortBy.relevancy.name,
                                style: GoogleFonts.lato(fontSize: 15),
                              )),
                          DropdownMenuItem(
                              value: SortBy.popularity.name,
                              child: Text(
                                SortBy.popularity.name,
                                style: GoogleFonts.lato(fontSize: 15),
                              )),
                          DropdownMenuItem(
                              value: SortBy.publishedAt.name,
                              child: Text(
                                SortBy.publishedAt.name,
                                style: GoogleFonts.lato(fontSize: 15),
                              )),
                        ],
                        value: sortBy,
                        onChanged: (String? value) {
                          setState(() {
                            sortBy = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            FutureBuilder<List<NewsModel>>(
              // future: getNewsList(),
              // future: NewsAPIServices.getAllNews(),
              future: newsTabType == NewsTabType.trending
                  ? newsProvider.fetchTopHeadlines()
                  : newsProvider.fetchAllNews(
                      page: currentPageNumber + 1, sortBy: sortBy),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting &&
                    snapShot.hasData) {
                  return newsTabType == NewsTabType.allNews
                      ? Flexible(
                          child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return NewsCardLoading(
                              newsTabType: newsTabType,
                            );
                          },
                        ))
                      : Flexible(
                          child: NewsCardLoading(
                          newsTabType: newsTabType,
                        ));
                } else if (snapShot.hasError) {
                  // TODO error handling
                  return Flexible(
                    child: EmptyNewsWidget(
                      text: "An error occurred: ${snapShot.error}",
                      imagePath: "assets/images/no_news.png",
                    ),
                  );
                } else if (snapShot.data == null) {
                  return const Flexible(
                      child: EmptyNewsWidget(
                    text: "No news found!",
                    imagePath: "assets/images/no_news.png",
                  ));
                }
                return Flexible(
                  child: newsTabType == NewsTabType.allNews
                      ? ListView.builder(
                          itemCount: snapShot.data!.length,
                          itemBuilder: (context, index) {
                            NewsModel data = snapShot.data![index];
                            return ChangeNotifierProvider.value(
                              value: data,
                              child: NewsCard(
                                key: UniqueKey(),
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          height: size.height * 0.7,
                          child: Swiper(
                            viewportFraction: 0.9,
                            layout: SwiperLayout.STACK,
                            itemWidth: size.width * 0.9,
                            itemCount: snapShot.data!.length,
                            itemBuilder: (context, index) {
                              NewsModel data = snapShot.data![index];
                              return ChangeNotifierProvider.value(
                                value: data,
                                child: TopTrending(
                                  key: UniqueKey(),
                                ),
                              );
                            },
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
