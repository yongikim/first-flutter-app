import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/CategoryRepository.dart';
import 'package:first_flutter_app/repositories/CategoryRepositoryInterface.dart';
import 'package:first_flutter_app/repositories/LabelRepository.dart';
import 'package:first_flutter_app/repositories/LabelRepositoryInterface.dart';
import 'package:first_flutter_app/repositories/RecordRepository.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';
import 'package:first_flutter_app/view_models/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'CardState.dart';
import 'Label.dart';

class StateBody {
  String _title;
  String get title => _title;

  List<CardState> _cards;
  List<CardState> get cards => _cards;

  StateBody(this._title, this._cards);
}

class HomeViewModel extends ChangeNotifier {
  final Map<int, StateBody> _state = {};
  Map<int, StateBody> get state => _state;

  late bool _isLoading;
  bool get isLoading => _isLoading;

  late final RecordRepositoryInterface _recordRep;
  late final CategoryRepositoryInterface _categoryRep;
  late final LabelRepositoryInterface _labelRep;

  HomeViewModel() {
    _recordRep = RecordRepository();
    _categoryRep = CategoryRepository();
    _labelRep = LabelRepository();

    _isLoading = true;
    _init().then((_) {
      _isLoading = false;
      notifyListeners();
    });
  }

  // Get data from DB
  Future<HomeViewModel?> _init() async {
    final int month = DateTime.now().month;
    final List<Record> records = await _recordRep.getRecordsByMonth(month, 0);

    if (records.isEmpty) {
      for (int i = 0; i < 3; i++) {
        // TODO: Create Category
        final Category category = await _categoryRep.create('New Category $i');

        for (int j = 0; j < 3; j++) {
          // TODO: Create Label
          final Label label = await _labelRep.create('New Label $j');

          // TODO: Create Record
          final int day = DateTime.now().day;
          final CreateRecordReq req =
              CreateRecordReq(0, category.id, label.id, month, day);
          final Record record = await _recordRep.create(req);

          records.add(record);
        }
      }
    }

    print(records.map((r) => r.toMap()));

    for (Record record in records) {
      final int categoryId = record.category.id;
      final Category category = Category(categoryId, record.category.name);
      final Label label = Label(record.label.id, record.label.name);
      final CardState cardState =
          CardState(category, label, record.amount, 0, 0);

      state.putIfAbsent(categoryId, () => StateBody(category.name, []));
      StateBody stateBody = state[categoryId]!;

      final CardState? targetCard = stateBody.cards
          .firstWhereOrNull((c) => c.label.id == cardState.label.id);
      if (targetCard == null) {
        stateBody.cards.add(cardState);
      } else {
        targetCard.todayTotal += cardState.todayTotal;
      }
    }

    return this;
  }

  Future add(int categoryId, int labelId, double value) async {
    final DateTime now = DateTime.now();
    final int month = now.month;
    final int day = now.day;
    final record = CreateRecordReq(value, categoryId, labelId, month, day);

    // This does not block UI transition.
    // It updates the UI when creating Record is complete after transition.
    _recordRep.create(record).then((Record _res) {
      final cardState = state[categoryId]
          ?.cards
          .firstWhere((card) => card.label.id == labelId);
      if (cardState != null) {
        cardState.todayTotal += value;
        notifyListeners();
      }
    }).catchError((e) {
      print(e);
    });
  }
}
