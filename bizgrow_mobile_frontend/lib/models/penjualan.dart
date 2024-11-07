class Penjualan {
  final String tanggal;
  final String id;
  final String produk;
  final int kuantitas;
  final int harga;
  final int total;

  Penjualan({
    required this.tanggal,
    required this.id,
    required this.produk,
    required this.kuantitas,
    required this.harga,
    required this.total,
  });

  // Factory method untuk membuat objek Penjualan dari JSON
  factory Penjualan.fromJson(Map<String, dynamic> json) {
    return Penjualan(
      tanggal: json['tanggal'],
      id: json['id'],
      produk: json['produk'],
      kuantitas: json['kuantitas'],
      harga: json['harga'],
      total: json['total'],
    );
  }
}
