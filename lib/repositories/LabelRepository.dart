import 'package:first_flutter_app/db/DBService.dart';
import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/models/Label.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';

import 'LabelRepositoryInterface.dart';

class LabelRepository implements LabelRepositoryInterface {
  // ignore: non_constant_identifier_names
  late final DBServiceInterface _DBService;

  LabelRepository() {
    _DBService = DBService();
  }

  Future<Label> create(CreateLabelReq req) async {
    if (req.name.isEmpty) {
      throw EmptyLabelNameException();
    }

    return _DBService.insertLabel(req);
  }

  Future<Label> findById(int id) async {
    return _DBService.findLabelById(id);
  }

  Future<Label> updateLabelName(int id, String name) async {
    final UpdateLabelReq req = UpdateLabelReq(name);
    await _DBService.updateLabel(id, req);

    return await _DBService.findLabelById(id);
  }
}

class CreateLabelReq {
  final String name;
  final int mainCategoryId;
  final int subCategoryId;

  CreateLabelReq(this.name, this.mainCategoryId, this.subCategoryId);

  Map<String, Object> toMap() {
    return {
      'name': name,
      'main_category_id': mainCategoryId,
      'sub_category_id': subCategoryId,
    };
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
