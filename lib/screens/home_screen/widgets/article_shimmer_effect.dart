import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmerEffect extends StatelessWidget {
  const ArticleShimmerEffect({
    Key? key,
    required this.size,
    required this.baseShimmerColor,
    required this.highlightShimmerColor,
    required this.widgetShimmerColor,
  }) : super(key: key);

  final Size size;
  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Color widgetShimmerColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
          onTap: () {

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
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Shimmer.fromColors(
                  baseColor: baseShimmerColor,
                  highlightColor: highlightShimmerColor,
                  child: Row(
                    children: [
                      Container(
                        width: size.height * 0.14,
                        height: size.height * 0.14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: widgetShimmerColor,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: size.height * 0.04,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: widgetShimmerColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.005,
                                  ),
                                  Container(
                                    height: size.height * 0.035,
                                    width: size.width * 0.4,
                                    decoration: BoxDecoration(
                                      color: widgetShimmerColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: widgetShimmerColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: size.height * 0.03,
                                        decoration: BoxDecoration(
                                          color: widgetShimmerColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
