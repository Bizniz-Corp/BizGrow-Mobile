class Stok {
  final String tanggal;
  final String id;
  final String produk;
  final int perubahan;
  final int total;

  Stok({
    required this.tanggal,
    required this.id,
    required this.produk,
    required this.perubahan,
    required this.total,
  });

  // Factory method untuk membuat objek Penjualan dari JSON
  factory Stok.fromJson(Map<String, dynamic> json) {
    return Stok(
      tanggal: json['tanggal'],
      id: json['id'],
      produk: json['produk'],
      perubahan: json['perubahan'],
      total: json['total'],
    );
  }
}
