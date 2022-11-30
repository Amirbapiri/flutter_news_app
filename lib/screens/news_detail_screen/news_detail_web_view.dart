import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../components/custom_listtile.dart';
import '../../services/utils.dart';

class NewsDetailWebView extends StatefulWidget {
  static const routeName = "/news-detail";

  const NewsDetailWebView({Key? key}) : super(key: key);

  @override
  State<NewsDetailWebView> createState() => _NewsDetailWebViewState();
}

class _NewsDetailWebViewState extends State<NewsDetailWebView> {
  late WebViewController webViewController;
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final Color color = utils.getColorForCurrentTheme;
    final Map<String, String> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final String newsUrl = arguments["url"]!;

    return WillPopScope(
      onWillPop: () async {
        if (await webViewController.canGoBack()) {
          webViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: color),
          centerTitle: true,
          title: Text(
            newsUrl,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 17.0,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () async {
                await _buildShowModalBottomSheet(color);
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                color: progress == 1 ? Colors.transparent : Colors.blue,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              Flexible(
                child: WebView(
                  initialUrl:newsUrl,
                  zoomEnabled: true,
                  onProgress: (progressValue) {
                    setState(() {
                      progress = progressValue / 100;
                    });
                  },
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _buildShowModalBottomSheet(Color color) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 70,
                margin: const EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "More options",
                  style: Utils.getMainTextStyle.copyWith(color: color),
                ),
              ),
              const Divider(thickness: 1),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: Column(
                  children: [
                    CustomListTile(
                      icon: Icons.share,
                      title: "Share",
                      onTap: () async {
                        try {
                          await Share.share(
                              "Checkout this news: ${await webViewController.currentUrl()}");
                        } catch (_) {}
                      },
                    ),
                    CustomListTile(
                      icon: Icons.open_in_browser,
                      title: "Open in browser",
                      onTap: () async {
                        try {
                          String? url = await webViewController.currentUrl();
                          await launchUrl(Uri.parse(url!));
                        } catch (e) {
                          throw 'Could not launch: $e';
                        } finally {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    CustomListTile(
                      icon: Icons.refresh,
                      title: "Refresh",
                      onTap: () async {
                        try {
                          await webViewController.reload();
                        } catch (_) {
                        } finally {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
