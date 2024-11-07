import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// 'https://raw.githubusercontent.com/Bizniz-Corp/BizGrow-Mobile/refs/heads/main/bizgrow_mobile_frontend/lib/assets/data/data_dummy.json'

Future<List<dynamic>> fetchNotes(url) async {
  var pathOrUrl = url;
  var response = await http.get(Uri.parse(pathOrUrl));

  List<dynamic> data = [];

  if (response.statusCode == 200) {
    var dataJson = json.decode(response.body);
    for (var dj in dataJson) {
      data.add(dj);
    }
  }

  return data;
}

Future<List<dynamic>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();

  return jsonDecode(input) as List<dynamic>;
}

Future<void> main() async {
  print('test');
  List<dynamic> data = await fetchNotes(
      'https://raw.githubusercontent.com/Bizniz-Corp/BizGrow-Mobile/refs/heads/main/bizgrow_mobile_frontend/lib/assets/data/data_dummy.json');

  if (data != null) {
    print('${data[0]['value']}');
  } else {
    print('No');
  }
}
