import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/utils.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  final IconData icon;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Utils.getMainTextStyle.copyWith(fontSize: 17.0),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
