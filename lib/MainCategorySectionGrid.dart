import 'package:first_flutter_app/CardState.dart';
import 'package:first_flutter_app/MainCategorySectionCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainCategorySectionGrid extends StatelessWidget {
  final String mainCategoryId;
  final List<CardState> cardStates;

  MainCategorySectionGrid(this.mainCategoryId, this.cardStates);

  @override
  Widget build(BuildContext context) {
    var cards = <Widget>[];
    this.cardStates.asMap().forEach((index, cardState) {
      cards.add(MainCategorySectionCard(this.mainCategoryId, cardState, index));
    });

    return SliverGrid(
      delegate: SliverChildListDelegate(
        cards,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}
