class Transaction {
  final double amount;
  final int categoryId;
  final int labelId;
  final DateTime date;

  Transaction(this.amount, this.categoryId, this.labelId, this.date);
}
