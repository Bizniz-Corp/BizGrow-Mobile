class SalesTransaction {
  final int salesId;
  final String productName;
  final String salesDate;
  final int salesQuantity;
  final double pricePerItem;
  final double total;

  SalesTransaction({
    required this.salesId,
    required this.productName,
    required this.salesDate,
    required this.salesQuantity,
    required this.pricePerItem,
    required this.total,
  });

  factory SalesTransaction.fromJson(Map<String, dynamic> json) {
    return SalesTransaction(
      salesId: json['sales_id'],
      productName: json['product_name'],
      salesDate: json['sales_date'],
      salesQuantity: json['sales_quantity'],
      pricePerItem: json['price_per_item'].toDouble(),
      total: json['total'].toDouble(),
    );
  }
}
