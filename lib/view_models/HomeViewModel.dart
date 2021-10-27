import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/MainCategoryRepository.dart';
import 'package:first_flutter_app/repositories/MainCategoryRepositoryInterface.dart';
import 'package:first_flutter_app/repositories/SubCategoryRepository.dart';
import 'package:first_flutter_app/repositories/SubCategoryRepositoryInterface.dart';
import 'package:first_flutter_app/repositories/LabelRepository.dart';
import 'package:first_flutter_app/repositories/LabelRepositoryInterface.dart';
import 'package:first_flutter_app/repositories/RecordRepository.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';
import 'package:first_flutter_app/models/MainCategory.dart';
import 'package:first_flutter_app/models/SubCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'CardState.dart';
import '../models/Label.dart';

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

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setCurrentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }

  late final RecordRepositoryInterface _recordRep;
  late final MainCategoryRepositoryInterface _mainCategoryRep;
  late final SubCategoryRepositoryInterface _subCategoryRep;
  late final LabelRepositoryInterface _labelRep;

  HomeViewModel() {
    _recordRep = RecordRepository();
    _mainCategoryRep = MainCategoryRepository();
    _subCategoryRep = SubCategoryRepository();
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

    // create sample data if no record exists
    if (records.isEmpty) {
      for (int i = 0; i < 3; i++) {
        final MainCategory mainCategory =
            await _mainCategoryRep.create('New Category $i');
        final SubCategory subCategory =
            await _subCategoryRep.create('New Category $i');

        for (int j = 0; j < 3; j++) {
          final Label label = await _labelRep.create('New Label $j');

          final int day = DateTime.now().day;
          final CreateRecordReq req =
              CreateRecordReq(0, mainCategory.id, subCategory.id, label.id, month, day);
          final Record record = await _recordRep.create(req);

          records.add(record);
        }
      }
    }

    print(records.map((r) => r.toMap()));

    for (Record record in records) {
      final int mainCategoryId = record.mainCategory.id;
      final int subCategoryId = record.subCategory.id;
      final MainCategory mainCategory =
          MainCategory(mainCategoryId, record.mainCategory.name);
      final SubCategory subCategory =
          SubCategory(subCategoryId, record.subCategory.name);
      final Label label = Label(record.label.id, record.label.name);
      final CardState cardState =
          CardState(mainCategory, subCategory, label, record.amount, 0, 0);

      state.putIfAbsent(mainCategoryId, () => StateBody(mainCategory.name, []));
      StateBody stateBody = state[mainCategoryId]!;

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

  Future add(int mainCategoryId, int subCategoryId, int labelId, double value) async {
    final DateTime now = DateTime.now();
    final int month = now.month;
    final int day = now.day;
    final record = CreateRecordReq(value, mainCategoryId, subCategoryId, labelId, month, day);

    // This does not block UI transition.
    // It updates the UI when creating Record is complete after transition.
    _recordRep.create(record).then((Record _res) {
      final cardState = state[mainCategoryId]
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

  Future create(int mainCategoryId, int? subCategoryId, String newLabelName,
      double value) async {
    // Get Month and Day
    final DateTime now = DateTime.now();
    final int month = now.month;
    final int day = now.day;

    // Get Label and Category
    final Label label = await _labelRep.create(newLabelName);
    final MainCategory mainCategory =
        await _mainCategoryRep.findById(mainCategoryId);

    if (subCategoryId == null) {
      final SubCategory subCategory = await _subCategoryRep.untitled();
      subCategoryId = subCategory.id;
    }
    final SubCategory subCategory =
        await _subCategoryRep.findById(subCategoryId);

    // Create Record
    final CreateRecordReq req =
        CreateRecordReq(value, mainCategoryId, subCategoryId, label.id, month, day);
    final Record record = await _recordRep.create(req);

    // Create Card
    final CardState newCardState =
        CardState(mainCategory, subCategory, label, record.amount, 0, 0);
    _state[mainCategoryId]?._cards.add(newCardState);

    notifyListeners();
  }
}
