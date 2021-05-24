import 'package:first_flutter_app/SubCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CardState.dart';

class RootState extends ChangeNotifier {
  final Map<String, List<CardState>> _cardStates = {};

  RootState() {
    for (int i = 0; i < 5; i++) {
      var mainCategoryId = 'Main Category $i';
      this._cardStates[mainCategoryId] = List.generate(5, (j) {
        var cardState = CardState();
        var subCategory = SubCategory();

        var subCategoryId = mainCategoryId + j.toString();

        subCategory.id = subCategoryId;
        subCategory.name = 'Sub Category Name $j';

        cardState.todayTotal = 0;
        cardState.mainCategoryId = mainCategoryId;
        cardState.subCategory = subCategory;
        cardState.lastMonthTotal = 0;
        cardState.thisMonthTotal = 0;

        return cardState;
      });
    }
  }

  Map<String, List<CardState>> get cardStates => _cardStates;

  void add(String mainCategoryId, String subCategoryId, double value) {
    var cards = _cardStates[mainCategoryId]!;
    cards.forEach((card) {
      if (card.subCategory.id == subCategoryId) {
        card.todayTotal += value;
      }
    });
  }
}
