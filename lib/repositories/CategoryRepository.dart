import 'package:first_flutter_app/db/DBService.dart';
import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/view_models/Category.dart';

import 'CategoryRepositoryInterface.dart';

class CategoryRepository implements CategoryRepositoryInterface {
  // ignore: non_constant_identifier_names
  late final DBServiceInterface _DBService;

  CategoryRepository() {
    _DBService = DBService();
  }

  Future<Category> create(String name) async {
    if (name.isEmpty) {
      throw EmptyCategoryNameException();
    }

    return _DBService.insertCategory(name);
  }

  Future<Category> findById(int id) async {
    return _DBService.findCategoryById(id);
  }
}

class EmptyCategoryNameException implements Exception {
  late String _message;

  EmptyCategoryNameException([String message = 'Label name is empty!']) {
    _message = message;
  }

  String toString() {
    return _message;
  }
}
