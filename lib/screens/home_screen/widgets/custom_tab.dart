import 'package:flutter/material.dart';

import '../../../services/utils.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.onTap,
    required this.fontSize,
  }) : super(key: key);

  final String title;
  final Color backgroundColor;
  final Function onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Text(
            title,
            style: Utils.getMainTextStyle.copyWith(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
