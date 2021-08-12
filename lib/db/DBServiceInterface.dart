import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';

abstract class DBServiceInterface {
  Future<CreateRecordResponse> insertRecord(CreateRecordRequest tran);
  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int labelId]);
}
