import 'package:first_flutter_app/MainCategorySectionGrid.dart';
import 'package:first_flutter_app/MainCategorySectionHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'CardState.dart';

class MainCategorySection extends StatelessWidget {
  final String title;
  final List<CardState> cards;

  MainCategorySection(this.title, this.cards);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: MainCategorySectionHeader(title: this.title),
      sliver: MainCategorySectionGrid(this.title, this.cards),
    );
  }
}
