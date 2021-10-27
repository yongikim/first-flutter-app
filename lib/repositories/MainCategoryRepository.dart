import 'package:first_flutter_app/db/DBService.dart';
import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/models/MainCategory.dart';

import 'MainCategoryRepositoryInterface.dart';

class MainCategoryRepository implements MainCategoryRepositoryInterface {
  // ignore: non_constant_identifier_names
  late final DBServiceInterface _DBService;

  MainCategoryRepository() {
    _DBService = DBService();
  }

  Future<MainCategory> create(String name) async {
    if (name.isEmpty) {
      throw EmptyCategoryNameException();
    }

    return _DBService.insertMainCategory(name);
  }

  Future<MainCategory> findById(int id) async {
    return _DBService.findMainCategoryById(id);
  }
}

class EmptyCategoryNameException implements Exception {
  late String _message;

  EmptyCategoryNameException([String message = 'Category name is empty!']) {
    _message = message;
  }

  String toString() {
    return _message;
  }
}
