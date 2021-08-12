import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/RecordRepository.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';
import 'package:first_flutter_app/view_models/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CardState.dart';
import 'Label.dart';

class HomeViewModel extends ChangeNotifier {
  late final Map<int, List<CardState>> _state;
  Map<int, List<CardState>> get state => _state;

  late final bool _isLoading;
  bool get isLoading => _isLoading;

  late final RecordRepositoryInterface _recordRep;

  HomeViewModel() {
    _recordRep = RecordRepository();

    _isLoading = true;
    _init().then((_) {
      _isLoading = false;
      notifyListeners();
    });
  }

  // Get data from DB
  Future<HomeViewModel?> _init() async {
    // TODO: 今月分のRecordの合計をcategoryとlabel毎に表示
    final int month = DateTime.now().month;
    final List<Record> records = await _recordRep.getRecordsByMonth(month, 0);

    final Map<int, List<CardState>> state = {};

    await Future.delayed(Duration(milliseconds: 3000));

    for (int i = 0; i < 5; i++) {
      final int categoryId = i;

      state[categoryId] = List.generate(5, (j) {
        // Category
        final String categoryName = 'Category Name $i';
        final Category category = Category(i, categoryName);

        // Label
        final int labelId = int.tryParse(categoryId.toString() + j.toString())!;
        final String labelName = 'Label Name $j';
        final Label label = Label(labelId, labelName);

        // Statistics
        final double todayTotal = 0;
        final double lastMonthTotal = 0;
        final double thisMonthTotal = 0;

        // cardState
        return CardState(
            category, label, todayTotal, lastMonthTotal, thisMonthTotal);
      });

      this._state = state;

      return this;
    }
  }

  Future add(int categoryId, int labelId, double value) async {
    final createdAt = DateTime.now();
    final record = CreateRecordRequest(value, categoryId, labelId, createdAt);

    // This does not block UI transition.
    // It updates the UI when creating Record is complete after transition.
    _recordRep.create(record).then((CreateRecordResponse _res) {
      final cardState =
          state[categoryId]?.firstWhere((card) => card.label.id == labelId);
      if (cardState != null) {
        cardState.todayTotal += value;
        notifyListeners();
      }
    }).catchError((e) {
      print(e);
    });
  }
}
