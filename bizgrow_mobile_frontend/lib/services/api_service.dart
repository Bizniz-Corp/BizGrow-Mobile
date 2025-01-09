import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bizgrow_mobile_frontend/models/pagination.dart';
import 'package:bizgrow_mobile_frontend/models/sales_transaction.dart';
import 'package:bizgrow_mobile_frontend/models/stock_change.dart';
import 'package:bizgrow_mobile_frontend/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // final String baseUrl = "http://10.0.2.2:8000/api";
  final String baseUrl = "http://192.168.1.15:8000/api";

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  /// Ambil Token yang Tersimpan
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// Logout dan Hapus Token
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  /// Cek Login Status
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') != null;
  }

  /// Register API
  Future<Map<String, dynamic>> register(
      Map<String, String> data, String filePath) async {
    try {
      print("Fields being sent: $data");
      print("File path: $filePath");
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/register'))
            ..fields.addAll(data)
            ..files.add(
                await http.MultipartFile.fromPath('file_surat_izin', filePath));

      print("Request Fields: ${request.fields}");
      print("Request Files: ${request.files}");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': json.decode(response.body),
        };
      } else {
        return {
          'success': false,
          'message':
              json.decode(response.body)['error'] ?? 'Failed to register',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  //API LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    print('Email: $email, Password: $password');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        // Simpan token ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', body['data']['token']);

        return {
          'success': true,
          'data': body,
        };
      } else {
        return {
          'success': false,
          'message': json.decode(response.body)['message'] ?? 'Failed to login',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getMonthlyProfit() async {
    final url = Uri.parse("$baseUrl/profit");
    final token = await getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          return {
            'total_pembelian': data['data']['total_pembelian'],
            'total_penjualan': data['data']['total_penjualan'],
          };
        } else {
          throw Exception("Gagal mendapatkan data dari server.");
        }
      } else {
        throw Exception(
            "Error: ${response.statusCode}, ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final String url = "$baseUrl/profile";
    final token = await getToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          return {
            'name': data['data']['name'],
          };
        } else {
          throw Exception("Gagal mendapatkan data profil.");
        }
      } else {
        throw Exception(
            "Error: ${response.statusCode}, ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }

  //Menarik data penjualan dari server
  Future<Map<String, dynamic>> fetchSalesHistory({
    required int page,
    int perPage = 10,
    String? productName,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final token = await getToken();
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
  }

  Future<List<Product>> fetchAllProduct() async {
    try {
      final token = await getToken();
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
  Future<Map<String, dynamic>> fetchStockHistory({
    required int page,
    int perPage = 10,
    String? productName,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final token = await getToken();
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

      final uri = Uri.parse('$baseUrl/stocks-history')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        print(jsonResponse['pagination']);
        final stockData = (jsonResponse['data'] as List)
            .map((data) => StockChange.fromJson(data))
            .toList();
        final pagination = Pagination.fromJson(jsonResponse['pagination']);
        return {
          'stockData': stockData,
          'pagination': pagination,
        };
      } else {
        throw Exception(
            'Failed to fetch stock history: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // Method to check the old password
  Future<String> checkPassword(String oldPassword) async {
    final token = await getToken();
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
  Future<String> editPassword(String newPassword) async {
    final token = await getToken();
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

  // API get data profile
  Future<Map<String, dynamic>> fetchProfile() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'data': json.decode(response.body),
      };
    } else {
      return {
        'success': false,
        'message': 'Failed to fetch profile data',
      };
    }
  }

  // API update profile
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/profile/edit'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'data': json.decode(response.body),
      };
    } else {
      return {
        'success': false,
        'message': 'Failed to update profile data',
      };
    }
  }

  // API Logout
  Future<Map<String, dynamic>> logoutUser() async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      logout();
      return {
        'success': true,
        'data': json.decode(response.body),
      };
    } else {
      return {
        'success': false,
        'message': 'Failed to logout',
      };
    }
  }

  Future<Map<String, dynamic>> insertSalesTransaction({
    required String token,
    required int productId,
    required String salesDate,
    required String salesQuantity,
    required String pricePerItem,
    required int total,
  }) async {
    final String url = "$baseUrl/"; // !! ISI WEY JANLUP

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
          'sales_date': salesDate,
          'sales_quantity': salesQuantity,
          'price_per_item': pricePerItem,
          'total': total,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          return {
            'status': 'success',
            'message': 'Data inserted successfully',
          };
        } else {
          throw Exception('Failed to insert data');
        }
      } else {
        throw Exception(
            'Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
