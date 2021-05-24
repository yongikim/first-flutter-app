import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainCategorySectionHeader extends StatelessWidget {
  MainCategorySectionHeader({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Theme.of(context).canvasColor,
      padding: EdgeInsetsDirectional.only(
        top: 16,
        start: 16,
        bottom: 16,
      ),
      margin: EdgeInsetsDirectional.only(),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
