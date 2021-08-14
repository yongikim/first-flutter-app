import 'package:first_flutter_app/view_models/Category.dart';

abstract class CategoryRepositoryInterface {
  Future<Category> create(String name);
  Future<Category> findById(int id);
}
