import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bizgrow_mobile_frontend/models/pagination.dart';
import 'package:bizgrow_mobile_frontend/models/sales_transaction.dart';
import 'package:bizgrow_mobile_frontend/models/stock_change.dart';
import 'package:bizgrow_mobile_frontend/models/product.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  //Menarik data penjualan dari server
  Future<Map<String, dynamic>> fetchSalesHistory({
    required String token,
    required int page,
    int perPage = 10,
    String? productName,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final queryParams = {
        'per_page': perPage.toString(),
        'page': page.toString(),
        if (productName != null &&
            productName.isNotEmpty &&
            productName != 'Semua')
          'product_name': productName,
        if (startDate != "null" && endDate != "null") ...{
          'start_date': startDate,
          'end_date': endDate,
        },
      };
      print('Query Parameters: $queryParams');

      final uri = Uri.parse('$baseUrl/sales-history')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        print(jsonResponse['pagination']);
        final salesData = (jsonResponse['data'] as List)
            .map((data) => SalesTransaction.fromJson(data))
            .toList();
        final pagination = Pagination.fromJson(jsonResponse['pagination']);
        return {
          'salesData': salesData,
          'pagination': pagination,
        };
      } else {
        throw Exception(
            'Failed to fetch sales history: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
    // final response = await http.get(
    //   Uri.parse("$baseUrl/sales-history"),
    //   headers: {
    //     'Authorization': 'Bearer $token',
    //   },
    // );

    // if (response.statusCode == 200) {
    //   final List<dynamic> data = json.decode(response.body)['data'];
    //   return data.map((e) => SalesTransaction.fromJson(e)).toList();
    // } else {
    //   throw Exception("Failed to fetch sales history");
    // }
  }

  Future<List<Product>> fetchAllProduct(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/products"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final products = (jsonResponse['data'] as List)
            .map((data) => Product.fromJson(data))
            .toList();
        return products;
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  //Menarik data perubahan stok dari server
  Future<List<StockChange>> fetchStockHistory(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/stocks-history"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((e) => StockChange.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch stock history");
    }
  }

  // Method to check the old password
  Future<String> checkPassword(String token, String oldPassword) async {
    final response = await http.post(
      Uri.parse("$baseUrl/profile/edit-password"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'passLama': oldPassword}),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody['message'];
    } else {
      throw Exception(responseBody['message'] ?? "Unknown error occurred");
    }
  }

  // Method to update the password
  Future<String> editPassword(String token, String newPassword) async {
    final response = await http.put(
      Uri.parse("$baseUrl/profile/edit-password"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'passBaru': newPassword}),
    );

    final responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody['message'];
    } else {
      throw Exception(responseBody['message'] ?? "Unknown error occurred");
    }
  }
}
