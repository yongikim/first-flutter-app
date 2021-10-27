import 'package:first_flutter_app/models/MainCategory.dart';

abstract class MainCategoryRepositoryInterface {
  Future<MainCategory> create(String name);
  Future<MainCategory> findById(int id);
}
