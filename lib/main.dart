import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'providers/news_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/bookmarks_screen/bookmarks_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/news_detail_screen/news_detail_web_view.dart';
import 'screens/news_detail_screen/news_details_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();



  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    () async {
      themeProvider.setDarkTheme =
          await themeProvider.themePreferences.getCurrentTheme();
    };
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News app',
          theme: Styles.themeData(themeProvider.getIsDarkTheme, context),
          home: const HomeScreen(),
          routes: {
            BookmarkScreen.routeName: (context) => const BookmarkScreen(),
            NewsDetailWebView.routeName: (context) => const NewsDetailWebView(),
            NewsDetailsScreen.routeName: (context) => const NewsDetailsScreen(),
          },
        ),
      ),
    );
  }
}
