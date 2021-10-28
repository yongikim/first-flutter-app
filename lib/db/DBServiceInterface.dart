import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/LabelRepository.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';
import 'package:first_flutter_app/models/MainCategory.dart';
import 'package:first_flutter_app/models/SubCategory.dart';
import 'package:first_flutter_app/models/Label.dart';

abstract class DBServiceInterface {
  Future<Record> insertRecord(CreateRecordReq req);
  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int labelId]);
  Future<MainCategory> insertMainCategory(String name);
  Future<MainCategory> findMainCategoryById(int id);
  Future<MainCategory> getUntitledMainCategory();
  Future<SubCategory> insertSubCategory(String name);
  Future<SubCategory> findSubCategoryById(int id);
  Future<SubCategory> getUntitledSubCategory();
  Future<Label> insertLabel(CreateLabelReq req);
  Future<Label> findLabelById(int id);
  Future<int> updateLabel(int id, UpdateLabelReq req);
}
