import 'package:first_flutter_app/models/Label.dart';
import 'package:first_flutter_app/repositories/LabelRepository.dart';

abstract class LabelRepositoryInterface {
  Future<Label> create(CreateLabelReq req);
  Future<Label> findById(int id);
  Future<Label> updateLabelName(int id, String name);
}
