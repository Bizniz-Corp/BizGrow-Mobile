class StockChange {
  final int stockChangeId;
  final String productName;
  final String changesDate;
  final int changesQuantity;
  final int totalStock;

  StockChange({
    required this.stockChangeId,
    required this.productName,
    required this.changesDate,
    required this.changesQuantity,
    required this.totalStock,
  });

  factory StockChange.fromJson(Map<String, dynamic> json) {
    return StockChange(
      stockChangeId: json['stock_change_id'],
      productName: json['product_name'],
      changesDate: json['changes_date'],
      changesQuantity: json['changes_quantity'],
      totalStock: json['total_stock'],
    );
  }
}
