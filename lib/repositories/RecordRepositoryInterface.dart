import 'package:first_flutter_app/models/Record.dart';

abstract class RecordRepositoryInterface {
  Future<Record> create(CreateRecordReq record);
  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int labelId]);
}

class CreateRecordReq {
  final double amount;
  final int mainCategoryId;
  final int? subCategoryId;
  final int labelId;
  final int month;
  final int day;

  CreateRecordReq(
      this.amount, this.mainCategoryId, this.subCategoryId,this.labelId, this.month, this.day);

  Map<String, Object?> toMap() {
    return {
      'amount': amount,
      'main_category_id': mainCategoryId,
      'sub_category_id': subCategoryId,
      'label_id': labelId,
      'month': month,
      'day': day
    };
  }
}

class GetMonthlyStatsResponse {
  final month;
  final dailyTotal;
  final monthlyTotal;

  GetMonthlyStatsResponse(this.month, this.dailyTotal, this.monthlyTotal);
}

class GetMonthlyStatsRequest {
  final int month;
  final int categoryId;
  final int? labelId;

  GetMonthlyStatsRequest(this.month, this.categoryId, [this.labelId]);
}
