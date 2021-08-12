import 'package:first_flutter_app/models/Record.dart';

abstract class RecordRepositoryInterface {
  Future<CreateRecordResponse> create(CreateRecordRequest record);
  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int labelId]);
}

class CreateRecordResponse {}

class CreateRecordRequest {
  final double amount;
  final int categoryId;
  final int labelId;
  final DateTime createdAt;

  CreateRecordRequest(
      this.amount, this.categoryId, this.labelId, this.createdAt);

  Map<String, Object> toMap() {
    return {
      'amount': amount,
      'category_id': categoryId,
      'label_id': labelId,
      'created_at': createdAt.toString()
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
