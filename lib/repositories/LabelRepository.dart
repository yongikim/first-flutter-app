import 'package:first_flutter_app/db/DBService.dart';
import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/view_models/Label.dart';

import 'LabelRepositoryInterface.dart';

class LabelRepository implements LabelRepositoryInterface {
  // ignore: non_constant_identifier_names
  late final DBServiceInterface _DBService;

  LabelRepository() {
    _DBService = DBService();
  }

  Future<Label> create(String name) async {
    if (name.isEmpty) {
      throw EmptyLabelNameException();
    }

    return _DBService.insertLabel(name);
  }

  Future<Label> findById(int id) async {
    return _DBService.findLabelById(id);
  }
}

class EmptyLabelNameException implements Exception {
  late String _message;

  EmptyLabelNameException([String message = 'Label name is empty!']) {
    _message = message;
  }

  String toString() {
    return _message;
  }
}
