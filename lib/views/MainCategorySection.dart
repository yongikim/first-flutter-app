import 'package:first_flutter_app/view_models/HomeViewModel.dart';
import 'package:first_flutter_app/views/MainCategorySectionGrid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view_models/CardState.dart';

class MainCategorySection extends StatelessWidget {
  final String title;
  final StateBody body;

  MainCategorySection(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Builder(builder: (BuildContext context) {
          return Container(
              color: Theme.of(context).canvasColor,
              child: CustomScrollView(
                key: PageStorageKey<String>(this.title),
                slivers: <Widget>[
                  SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context)),
                  SliverPadding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 2.0, right: 2.0),
                      sliver:
                          MainCategorySectionGrid(this.title, this.body.cards))
                ],
              ));
        }));
  }
}
