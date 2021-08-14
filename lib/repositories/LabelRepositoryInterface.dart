import 'package:first_flutter_app/view_models/Label.dart';

abstract class LabelRepositoryInterface {
  Future<Label> create(String name);
  Future<Label> findById(int id);
}
