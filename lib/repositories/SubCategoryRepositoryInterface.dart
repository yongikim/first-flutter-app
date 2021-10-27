import 'package:first_flutter_app/models/SubCategory.dart';

abstract class SubCategoryRepositoryInterface {
  Future<SubCategory> create(String name);
  Future<SubCategory> findById(int id);
  Future<SubCategory> untitled();
}
