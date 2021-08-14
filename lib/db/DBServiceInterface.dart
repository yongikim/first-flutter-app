import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';
import 'package:first_flutter_app/view_models/Category.dart';
import 'package:first_flutter_app/view_models/Label.dart';

abstract class DBServiceInterface {
  Future<Record> insertRecord(CreateRecordReq record);
  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int labelId]);
  Future<Category> insertCategory(String name);
  Future<Category> findCategoryById(int id);
  Future<Label> insertLabel(String name);
  Future<Label> findLabelById(int id);
}
