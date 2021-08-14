import 'package:first_flutter_app/models/Record.dart';

abstract class RecordRepositoryInterface {
  Future<Record> create(CreateRecordReq record);
  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int labelId]);
}

class CreateRecordReq {
  final double amount;
  final int categoryId;
  final int labelId;
  final int month;
  final int day;

  CreateRecordReq(
      this.amount, this.categoryId, this.labelId, this.month, this.day);

  Map<String, Object?> toMap() {
    return {
      'amount': amount,
      'category_id': categoryId,
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
