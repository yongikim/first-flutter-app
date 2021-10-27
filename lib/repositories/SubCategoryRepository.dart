import 'package:first_flutter_app/db/DBService.dart';
import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/models/SubCategory.dart';

import 'SubCategoryRepositoryInterface.dart';

class SubCategoryRepository implements SubCategoryRepositoryInterface {
  // ignore: non_constant_identifier_names
  late final DBServiceInterface _DBService;

  SubCategoryRepository() {
    _DBService = DBService();
  }

  Future<SubCategory> create(String name) async {
    if (name.isEmpty) {
      throw EmptyCategoryNameException();
    }

    return _DBService.insertSubCategory(name);
  }

  Future<SubCategory> findById(int id) async {
    return _DBService.findSubCategoryById(id);
  }

  Future<SubCategory> untitled() async {
    return _DBService.getUntitledSubCategory();
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
