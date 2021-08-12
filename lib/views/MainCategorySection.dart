import 'package:first_flutter_app/views/MainCategorySectionGrid.dart';
import 'package:first_flutter_app/views/MainCategorySectionHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../view_models/CardState.dart';

class MainCategorySection extends StatelessWidget {
  final String title;
  final List<CardState> cardStates;

  MainCategorySection(this.title, this.cardStates);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: MainCategorySectionHeader(title: this.title),
      sliver: MainCategorySectionGrid(this.title, this.cardStates),
    );
  }
}
