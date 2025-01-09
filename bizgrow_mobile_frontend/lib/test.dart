import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class PenjualanPage extends StatefulWidget {
  @override
  _PenjualanPageState createState() => _PenjualanPageState();
}

class _PenjualanPageState extends State<PenjualanPage> {
  List<Penjualan> penjualanList = [];

  // Fungsi untuk membaca file JSON dan mengubahnya ke objek Penjualan
  Future<void> loadPenjualanData() async {
    // Membaca data JSON dari assets
    String jsonString =
        await rootBundle.loadString('lib/assets/data/penjualan.json');

    // Parsing JSON
    List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      penjualanList =
          jsonResponse.map((data) => Penjualan.fromJson(data)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadPenjualanData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Riwayat Penjualan")),
      body: ListView.builder(
        itemCount: penjualanList.length,
        itemBuilder: (context, index) {
          Penjualan penjualan = penjualanList[index];
          return ListTile(
            title: Text(penjualan.produk),
            subtitle: Text(
                "Tanggal: ${penjualan.tanggal} | Total: Rp ${penjualan.total}"),
            trailing: Text("Qty: ${penjualan.kuantitas}"),
          );
        },
      ),
    );
  }
}
