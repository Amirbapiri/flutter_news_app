import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/bookmarks_screen/bookmarks_screen.dart';
import 'package:provider/provider.dart';

import '../components/custom_listtile.dart';
import '../providers/theme_provider.dart';
import '../services/utils.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/newspaper.png",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "SlippyJimmy",
                  style: GoogleFonts.lobster(
                    fontSize: 20.0,
                    letterSpacing: 2,
                  ),
                )
              ],
            ),
          ),
          CustomListTile(
            icon: IconlyBold.home,
            title: "Home",
            onTap: () {},
          ),
          CustomListTile(
            icon: IconlyBold.bookmark,
            title: "Bookmarks",
            onTap: () {
              Navigator.pushNamed(context, BookmarkScreen.routeName);
            },
          ),
          const Divider(thickness: 3),
          Center(
            child: SwitchListTile(
              title: Text(
                themeProvider.getIsDarkTheme ? 'Dark' : 'Light',
                style: const TextStyle(fontSize: 18.0),
              ),
              secondary: Icon(
                themeProvider.getIsDarkTheme
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Theme.of(context).colorScheme.secondary,
              ),
              value: themeProvider.getIsDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  themeProvider.setDarkTheme = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
