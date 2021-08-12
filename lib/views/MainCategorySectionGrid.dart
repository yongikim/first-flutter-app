import 'package:first_flutter_app/view_models/CardState.dart';
import 'package:first_flutter_app/views/MainCategorySectionCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainCategorySectionGrid extends StatelessWidget {
  final String mainCategoryId;
  final List<CardState> cardStates;

  MainCategorySectionGrid(this.mainCategoryId, this.cardStates);

  @override
  Widget build(BuildContext context) {
    final cardWidgets = this.cardStates.asMap().entries.map((e) {
      final cardState = e.value;
      final index = e.key;
      return MainCategorySectionCard(this.mainCategoryId, cardState, index);
    }).toList();

    return SliverGrid(
      delegate: SliverChildListDelegate(
        cardWidgets,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}
