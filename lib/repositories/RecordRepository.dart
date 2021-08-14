import 'package:first_flutter_app/db/DBService.dart';
import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';

class RecordRepository implements RecordRepositoryInterface {
  // ignore: non_constant_identifier_names
  late final DBServiceInterface _DBService;

  RecordRepository() {
    _DBService = DBService();
  }

  Future<Record> create(CreateRecordReq req) async {
    // if (req.amount == 0) {
    //   throw ZeroException();
    // }

    return _DBService.insertRecord(req);
  }

  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int? labelId]) async {
    final records = await _DBService.getRecordsByMonth(month, categoryId);
    return records;
  }
}

class ZeroException implements Exception {
  late String _message;

  ZeroException([String message = 'Value is zero!']) {
    _message = message;
  }

  String toString() {
    return _message;
  }
}
